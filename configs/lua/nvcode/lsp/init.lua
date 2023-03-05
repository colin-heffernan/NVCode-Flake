vim.api.nvim_exec(
	[[
		packadd nvim-lspconfig
		packadd null-ls.nvim
		packadd schemastore-nvim
	]],
	true
)

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify "LSP not found."
	return
end

require("nvcode.lsp.configs")
require("nvcode.lsp.handlers").setup()
-- require("nvcode.lsp.nullls")
