local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify "Telescope not found."
	return
end

telescope.setup {
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
		}
	}
}

telescope.load_extension("notify")
telescope.load_extension("projects")
