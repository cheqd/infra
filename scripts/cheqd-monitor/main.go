package cheqdmonitor

func main() {
	am := NewAlertManager()

	go DiskCheck(am)
	go ResourceCheck(am)
	go CosmovisorCheck(am)
	go SyncCheck(am)
	go PeerCheck(am)
}
