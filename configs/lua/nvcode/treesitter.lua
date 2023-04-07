vim.api.nvim_exec(
	[[
		packadd nvim-treesitter
		packadd nvim-ts-autotag
		packadd nvim-ts-context-commentstring
	]],
	true
)

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	vim.notify "Treesitter not found."
	return
end

configs.setup {
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocme = false,
	}
}
