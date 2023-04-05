vim.api.nvim_exec(
	[[
		packadd nvim-lspconfig
		" packadd null-ls.nvim
		packadd schemastore-nvim
	]],
	true
)

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	vim.notify "LSP not found."
	return
end

--[[ require("nvcode.lsp.configs") ]]
--[[ require("nvcode.lsp.handlers").setup() ]]
--[[ require("nvcode.lsp.nullls") ]]

local servers = {
	"bashls",
	"clangd",
	"cssls",
	"dockerls",
	"eslint",
	"graphql",
	"hls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"pyright",
	"rnix",
	"rust_analyzer",
	"svelte",
	"texlab",
	"tsserver",
	"vimls"
}

for _, server in pairs(servers) do
	local opts = {
		--[[ on_attach = require("nvcode.lsp.handlers").on_attach,
		capabilities = require("nvcode.lsp.handlers").capabilities, ]]
	}
	local has_custom_opts, server_custom_opts = pcall(require, "nvcode.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = { " " },
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.keymap.set("n", "<Space>l", vim.diagnostic.open_float)
