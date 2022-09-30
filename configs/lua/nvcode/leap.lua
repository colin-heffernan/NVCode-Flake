vim.api.nvim_exec(
	[[
		packadd leap-nvim
	]],
	true
)

local status_ok, leap = pcall(require, "leap")
if not status_ok then
	vim.notify "Leap not found."
	return
end

leap.set_default_keymaps()
