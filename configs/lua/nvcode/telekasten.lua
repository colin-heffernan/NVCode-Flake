require("nvcode.telescope")
vim.api.nvim_exec(
	[[
		packadd telekasten-nvim
	]],
	true
)

local status_ok, telescope = pcall(require, "telekasten")
if not status_ok then
	vim.notify "Telekasten not found."
	return
end

telekasten.setup {
	home = vim.fn.expand("~/Notes")
}
