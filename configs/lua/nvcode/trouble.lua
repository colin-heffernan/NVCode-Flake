vim.api.nvim_exec(
	[[
		packadd trouble.nvim
	]],
	true
)

local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	vim.notify "Trouble not found."
	return
end

trouble.setup {
}
