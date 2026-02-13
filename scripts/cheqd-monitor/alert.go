package cheqdmonitor

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os/exec"
	"sync"
	"time"

	"github.com/shirou/gopsutil/v3/cpu"
	"github.com/shirou/gopsutil/v3/disk"
	"github.com/shirou/gopsutil/v3/mem"
)

type StatusResponse struct {
	Result struct {
		SyncInfo struct {
			LatestBlockHeight string `json:"latest_block_height"`
		} `json:"sync_info"`
	} `json:"result"`
}

type NetInfo struct {
	Result struct {
		NPeers int `json:"n_peers"`
	} `json:"result"`
}

type AlertState struct {
	Active      bool
	LastUpdated time.Time
}

type AlertManager struct {
	mu     sync.Mutex
	alerts map[string]*AlertState
}

func NewAlertManager() *AlertManager {
	return &AlertManager{
		alerts: make(map[string]*AlertState),
	}
}

func (a *AlertManager) Trigger(name, msg, webohook string, retryIn time.Duration) {
	a.mu.Lock()
	defer a.mu.Unlock()

	state, exists := a.alerts[name]
	if !exists {
		state = &AlertState{}
		a.alerts[name] = state
	}

	now := time.Now()

	if !state.Active || now.Sub(state.LastUpdated) >= retryIn {
		SendSlackNotification(webohook, msg)
		state.Active = true
		state.LastUpdated = now
	}
}

func (a *AlertManager) Alert(name, msg, webhook string) {
	a.mu.Lock()
	defer a.mu.Unlock()

	state, exists := a.alerts[name]
	if !exists {
		state = &AlertState{}
		a.alerts[name] = state
	}

	if !state.Active {
		SendSlackNotification(webhook, msg)
		state.Active = true
		state.LastUpdated = time.Now()
	}
}

func (a *AlertManager) Resolve(name, msg, webhook string) {
	a.mu.Lock()
	defer a.mu.Unlock()

	state, exists := a.alerts[name]
	if exists && state.Active {
		SendSlackNotification(webhook, msg)
		state.Active = false
	}
}

func (a *AlertManager) IsActive(name string) bool {
	a.mu.Lock()
	defer a.mu.Unlock()

	state, exists := a.alerts[name]
	return exists && state.Active
}

func DiskCheck(am *AlertManager) {

	ticker := time.NewTicker(DiskInterval)

	for range ticker.C {
		usage, err := disk.Usage("/")
		if err != nil {
			log.Println(err)
			continue
		}

		freeGB := float64(usage.Free) / (1024 * 1024 * 1024)

		if freeGB < DiskThresholdGB {
			msg := fmt.Sprintf("🚨 Disk space low: %.2f GB free on /", freeGB)
			am.Trigger("disk", msg, cfg.WarningWebhook, DiskRetrigger)
		} else {
			am.Resolve("disk", fmt.Sprintf("✅ Disk space restored: %.2f GB free", freeGB), cfg.WarningWebhook)
		}
	}

}

func ResourceCheck(am *AlertManager) {
	ticker := time.NewTicker(ResourceInterval)

	for range ticker.C {
		cpuPercent, err := cpu.Percent(0, false)
		if err != nil || len(cpuPercent) == 0 {
			log.Println("CPU check error:", err)
			continue
		}

		memInfo, err := mem.VirtualMemory()
		if err != nil {
			log.Println("Memory check error:", err)
			continue
		}

		cpuVal := cpuPercent[0]
		ramVal := memInfo.UsedPercent

		if cpuVal > ResourceThresholdPercent || ramVal > ResourceThresholdPercent {
			msg := fmt.Sprintf("⚠️ High resource usage — CPU: %.1f%%, RAM: %.1f%%", cpuVal, ramVal)
			am.Alert("resource", cfg.WarningWebhook, msg)
		} else {
			am.Resolve("resource", fmt.Sprintf("✅ Resource usage normal — CPU: %.1f%%, RAM: %.1f%%", cpuVal, ramVal), cfg.WarningWebhook)
		}
	}
}

func CosmovisorCheck(am *AlertManager) {
	ticker := time.NewTicker(CosmovisorInterval)

	for range ticker.C {
		cmd := exec.Command("pgrep", "cosmovisor")
		err := cmd.Run()

		if err != nil {
			am.Trigger(
				"cosmovisor",
				"🚨 Cosmovisor NOT running!",
				cfg.AlertWebhook,
				CosmovisorRetrigger,
			)
		} else {
			am.Resolve(
				"cosmovisor",
				"✅ Cosmovisor back online",
				cfg.AlertWebhook,
			)
		}
	}
}

func SyncCheck(am *AlertManager) {
	ticker := time.NewTicker(SyncInterval)

	for range ticker.C {
		local := getHeight(cfg.LocalnetRpcUrl)
		var remote int64
		if cfg.Network == Testnet {
			remote = getHeight(TestnetRpcUrl)
		} else {
			remote = getHeight(MainnetRpcUrl)
		}

		if remote-local > MaxSyncHeightDifference {
			msg := fmt.Sprintf("🚨 Node out of sync — local: %d, remote: %d", local, remote)
			am.Trigger("sync", msg, cfg.WarningWebhook, SyncRetrigger)
		} else {
			am.Resolve("sync", fmt.Sprintf("✅ Node back in sync — local: %d, remote: %d", local, remote), cfg.WarningWebhook)
		}
	}
}

func PeerCheck(am *AlertManager) {
	ticker := time.NewTicker(PeerInterval)

	for range ticker.C {
		resp, err := http.Get(cfg.LocalnetRpcUrl + "/net_info")
		if err != nil {
			continue
		}
		defer resp.Body.Close()

		var n NetInfo
		json.NewDecoder(resp.Body).Decode(&n)

		if n.Result.NPeers == 0 {
			am.Alert("peers", "⚠️ Peer count dropped to 0", cfg.WarningWebhook)
		}

		if n.Result.NPeers > 0 {
			am.Resolve("peers", fmt.Sprintf("✅ Peers reconnected (count: %d)", n.Result.NPeers), cfg.WarningWebhook)
		}
	}
}

// Helpers
func getHeight(url string) int64 {
	resp, err := http.Get(url + "/status")
	if err != nil {
		return 0
	}
	defer resp.Body.Close()

	var s StatusResponse
	json.NewDecoder(resp.Body).Decode(&s)

	var height int64
	fmt.Sscan(s.Result.SyncInfo.LatestBlockHeight, &height)
	return height
}

func SendSlackNotification(webhook, message string) error {
	payload := map[string]string{"text": message}
	body, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("failed to marshal payload: %w", err)
	}

	resp, err := http.Post(webhook, "application/json", bytes.NewBuffer(body))
	if err != nil {
		return fmt.Errorf("failed to send request: %w", err)
	}

	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("slack API returned non-200 status: %d", resp.StatusCode)
	}

	return nil
}
