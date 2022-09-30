local status_ok, octo = pcall(require, "octo")
if not status_ok then
	vim.notify "Octo not found."
	return
end

octo.setup {
}
