local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify "NvimTree not found."
	return
end

-- vim.cmd('au VimEnter * exec "NvimTreeToggle"')

nvim_tree.setup {
	open_on_tab = true,
	respect_buf_cwd = true,
	sync_root_with_cwd = true,
	renderer = {
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				item = "├ ",
				bottom = "─",
				none = "  ",
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_root = false
	}
}

vim.api.nvim_exec(
	[[
		hi NvimTreeVertSplit guibg=#1a1b26 guifg=#1a1b26
	]],
	true
)
