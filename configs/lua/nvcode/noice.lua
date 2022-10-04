local status_ok, noice = pcall(require, "noice")
if not status_ok then
	vim.notify "Noice not found."
	return
end

noice.setup {
}
