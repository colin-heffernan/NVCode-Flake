local status_ok, nvim_tree = pcall(require, "neo-tree")
if not status_ok then
	vim.notify "NeoTree not found."
	return
end

vim.api.nvim_exec(
	[[
		let g:neo_tree_remove_legacy_commands = 1
	]],
	true
)

nvim_tree.setup {
	close_if_last_window = true,
	sort_case_insensitive = true,
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false
		}
	}
}
