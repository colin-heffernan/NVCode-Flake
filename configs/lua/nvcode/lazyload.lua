-- Load configs for lazyloaded plugins on BufRead and BufNewFile
local onFileOpen = function()
	require("nvcode.lsp")
	require("nvcode.cmp")
	require("nvcode.dap")
	require("nvcode.indentblankline")
	require("nvcode.gitsigns")
	require("nvcode.neorg")
	require("nvcode.comment")
	require("nvcode.zen")
	require("nvcode.colorizer")
	require("nvcode.trouble")
	require("nvcode.todo")
	require("nvcode.ccc")
	require("nvcode.leap")
end

vim.api.nvim_create_autocmd(
	{"BufRead", "BufNewFile"},
	{
		callback = onFileOpen
	}
)

-- Load configs for lazyloaded plugins on InsertEnter
local onInsert = function ()
	require("nvcode.autopairs")
end

vim.api.nvim_create_autocmd(
	{"InsertEnter"},
	{
		callback = onInsert
	}
)
