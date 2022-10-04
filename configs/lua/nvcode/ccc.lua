local status_ok, ccc = pcall(require, "ccc")
if not status_ok then
	vim.notify "CCC not found."
	return
end

ccc.setup {
	highlighter = {
		enable = true
	},
	mappings = {
		["<right>"] = ccc.mapping.increase1,
		["<left>"] = ccc.mapping.decrease1
	}
}
