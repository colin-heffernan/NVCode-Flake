-- Options variables
local opts = {
	noremap = true,
	silent = true
}

local keymap = vim.api.nvim_set_keymap

-- Normal
-- Window navigation
keymap("n", "<C-Up>", "<C-w>k", opts)
keymap("n", "<C-Down>", "<C-w>j", opts)
keymap("n", "<C-Left>", "<C-w>h", opts)
keymap("n", "<C-Right>", "<C-w>l", opts)

-- Window resizing
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Splits
keymap("n", "<Space>sv", "<C-w>v", opts)
keymap("n", "<Space>sh", "<C-w>s", opts)

-- Toggle NeoTree
keymap("n", "<Space><Space>", ":Neotree toggle<CR>", opts)

-- Toggle Zen Mode
keymap("n", "<Space>z", ":ZenMode<CR>", opts)

-- Toggle Terminals
keymap("n", "<Space>t", ":ToggleTerm direction=horizontal<CR>", opts)
keymap("n", "<Space>g", ":ToggleTerm direction=float<CR>", opts)
keymap("t", "<C-Esc>", "<C-\\><C-n>:ToggleTerm<CR>", opts)

-- Toggle Trouble
keymap("n", "<Space>d", ":Trouble workspace_diagnostics<CR>", opts)

-- Search files
keymap("n", "<Space>ff", ":Telescope find_files hidden=true<CR>", opts)
keymap("n", "<Space>fo", ":Telescope oldfiles<CR>", opts)
keymap("n", "<Space>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<Space>fp", ":Telescope projects<CR>", opts)

-- LSPSaga
keymap("n", "<Space>lf", ":Lspsaga lsp_finder<CR>", opts)
keymap("n", "<Space>la", ":Lspsaga code_action<CR>", opts)

-- Visual
-- Indents
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Hydra
local status_ok, hydra = pcall(require, "hydra")
if not status_ok then
	vim.notify "Hydra not found."
	return
end

hydra {
	name = "Buffer switch",
	mode = "n",
	config = {
		on_exit = function()
			print ""
		end
	},
	body = "<Space>b",
	heads = {
		{ "<Right>", "<Plug>(cokeline-focus-next)", { silent = true } },
		{ "<Left>", "<Plug>(cokeline-focus-prev)", { silent = true } },
		{ "k", [[:if len(getbufinfo({"buflisted":1})) > 1 | bp | else | execute "Alpha" | endif | bd! #<CR>]], { silent = true } }
	}
}
