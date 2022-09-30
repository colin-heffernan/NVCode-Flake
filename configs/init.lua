-- Keep track of start time for Alpha to use later
vim.g.start_time = vim.fn.reltime()

-- Load configs for autoloaded plugins
require("nvcode.options")
require("nvcode.keymaps")
require("nvcode.notify")
require("nvcode.colorscheme")
require("nvcode.lualine")
require("nvcode.cokeline")
require("nvcode.neotree")
require("nvcode.telescope")
require("nvcode.project")
require("nvcode.octo")
require("nvcode.toggleterm")
require("nvcode.treesitter")
require("nvcode.lazyload")
require("nvcode.alpha")
