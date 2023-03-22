local status_ok, zk = pcall(require, "zk")
if not status_ok then
	vim.notify "ZK not found."
	return
end

zk.setup {
	picker = "telescope"
}
