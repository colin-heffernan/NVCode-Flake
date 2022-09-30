vim.api.nvim_exec(
	[[
		packadd nvim-autopairs
	]],
	true
)

local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	vim.notify "Autopairs not found."
	return
end

npairs.setup {
	check_ts = true,
}
