package cheqdmonitor

import (
	"os"
	"time"
)

const (
	Mainnet       = "mainnet"
	Testnet       = "testnet"
	TestnetRpcUrl = "https://rpc.cheqd.network"
	MainnetRpcUrl = "https://rpc.cheqd.net"
)

type Config struct {
	LocalnetRpcUrl string
	AlertWebhook   string
	WarningWebhook string
	Network        string
}

var cfg = Config{
	Network:        Testnet,
	LocalnetRpcUrl: "http://localhost:26657",
	WarningWebhook: os.Getenv("SLACK_WARNING_WEBHOOK"),
	AlertWebhook:   os.Getenv("SLACK_ALERT_WEBHOOK"),
}

const (
	DiskThresholdGB = 2

	DiskInterval       = 5 * time.Minute
	ResourceInterval   = 5 * time.Minute
	SyncInterval       = 5 * time.Minute
	CosmovisorInterval = 5 * time.Minute
	PeerInterval       = 5 * time.Minute

	DiskRetrigger       = 6 * time.Hour
	SyncRetrigger       = 1 * time.Hour
	CosmovisorRetrigger = 1 * time.Hour

	ResourceThresholdPercent = 80
	MaxSyncHeightDifference  = 1
)
