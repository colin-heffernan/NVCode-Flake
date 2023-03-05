local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	vim.notify "Treesitter not found."
	return
end

configs.setup {
	autopairs = {
		enable = true,
	},
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
