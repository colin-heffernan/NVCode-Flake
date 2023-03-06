vim.api.nvim_exec(
	[[
		packadd indent-blankline-nvim
	]],
	true
)

local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	vim.notify "Indent Blankline not found."
	return
end

vim.g.indent_blankline_buftype_exclude = {
	"terminal",
	"nofile",
}
vim.g.indent_blankline_filetype_exclude = {
	"help",
	"dashboard",
	"alpha",
	"lspinfo",
	"lsp-installer",
	"TelescopePrompt",
	"TelescopeResults",
	"packer",
	"NvimTree",
	"neo-tree",
	"norg",
}

indent_blankline.setup({
	show_current_context = true,
	show_current_context_start = true,
})
