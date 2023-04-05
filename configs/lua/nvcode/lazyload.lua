-- Load configs for lazyloaded plugins on BufRead and BufNewFile
local function onFileOpen()
	require("nvcode.lsp")
	--[[ require("nvcode.dap") ]]
	require("nvcode.cmp.lazy")
	require("nvcode.indentblankline")
	require("nvcode.gitsigns")
	--[[ require("nvcode.neorg") ]]
	require("nvcode.mkdnflow")
	require("nvcode.comment")
	--[[ require("nvcode.zen") ]]
	--[[ require("nvcode.trouble") ]]
	--[[ require("nvcode.lspsaga") ]]
	require("nvcode.todo")
	require("nvcode.leap")
end

vim.api.nvim_create_autocmd(
	{"BufRead", "BufNewFile"},
	{
		callback = onFileOpen
	}
)

-- Load configs for lazyloaded plugins on InsertEnter
local function onInsert()
	require("nvcode.autopairs")
end

vim.api.nvim_create_autocmd(
	{"InsertEnter"},
	{
		callback = onInsert
	}
)
