vim.api.nvim_exec(
	[[
		packadd toggleterm-nvim
	]],
	true
)

local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	vim.notify "Toggleterm not found."
	return
end

toggleterm.setup {
}
