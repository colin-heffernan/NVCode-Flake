local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify "Lualine not found."
	return
end

lualine.setup {
	options = {
		globalstatus = true
	},
	sections = {
		lualine_a = {"mode"},
		lualine_b = {"filetype"},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {"diagnostics"},
		lualine_z = {"branch", "diff"}
	}
}
