local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify "Lualine not found."
	return
end

lualine.setup {
	options = { globalstatus = true, },
}
