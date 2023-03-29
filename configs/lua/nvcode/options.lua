-- Options
vim.o.cmdheight = 2					-- 2-row command line
vim.o.completeopt = "menuone,noselect"			-- [FOR CMP, IDK WHAT IT DOES]
vim.o.cursorline = false					-- Highlight cursor line
vim.o.ignorecase = true					-- Ignore case in search patterns
vim.o.laststatus = 3					-- Global status line
vim.o.number = true					-- Numbered lines
vim.o.numberwidth = 4					-- Line number column width
vim.o.pumheight = 10					-- Popup menu height
vim.o.scrolloff = 3					-- Buffer between selected line and screen edge (vertical)
vim.o.sidescrolloff = 3					-- Buffer between selected line and screen edge (horizontal)
vim.o.showmode = false					-- Hide mode indicator
vim.o.showtabline = 0					-- Never show tab line
vim.o.signcolumn = "yes"				-- Always show sign column
vim.o.smartcase = true					-- Smart case
vim.o.smartindent = true				-- Smart indent
vim.o.swapfile = false					-- Disable swapfile
vim.o.termguicolors = true				-- Enable terminal colors
vim.o.undofile = true					-- Persistent undo
vim.o.updatetime = 300					-- Faster completion
vim.o.wrap = false					-- Don't break lines
vim.o.writebackup = false				-- No backup before overwriting file

-- Run
--vim.cmd('au VimEnter * exec "NvimTreeToggle"')		-- Run NvimTree on startup
