-- Options variables
local opts = {
	noremap = true,
	silent = true
}

local keymap = vim.keymap.set

-- Normal
-- Window navigation
keymap("n", "<C-Up>", "<C-w>k", opts)
keymap("n", "<C-Down>", "<C-w>j", opts)
keymap("n", "<C-Left>", "<C-w>h", opts)
keymap("n", "<C-Right>", "<C-w>l", opts)

-- Buffer navigation
--[[ keymap("n", "<S-Left>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-Right>", ":BufferLineCycleNext<CR>", opts) ]]
keymap("n", "<Space>k", ":BufferLinePickClose<CR>", opts)

-- Splits
keymap("n", "<Space>v", "<C-w>v", opts)
keymap("n", "<Space>h", "<C-w>s", opts)

-- Toggle NeoTree
keymap("n", "<Space>e", ":Neotree toggle<CR>", opts)


-- Toggle Terminals
keymap("n", "<C-Esc>", ":ToggleTerm direction=float<CR>", opts)
keymap("t", "<C-Esc>", "<C-\\><C-n>:ToggleTerm<CR>", opts)

-- Search
keymap("n", "<Space>f", ":Telescope find_files hidden=true<CR>", opts)
keymap("n", "<Space>o", ":Telescope oldfiles<CR>", opts)
--[[ keymap("n", "<Space>n", ":ZkTags<CR>", opts) ]]

-- Visual
-- Indents
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
