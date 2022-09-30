local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify "LSP not found."
	return
end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	vim.notify "Null-LS not found."
	return
end

local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
	debug = true,
	sources = {
		diagnostics.eslint,
		diagnostics.jsonlint,
		diagnostics.luacheck,
		diagnostics.pylint,
		diagnostics.shellcheck,
		diagnostics.statix,
		diagnostics.stylelint,
		diagnostics.tidy,
	}
}
