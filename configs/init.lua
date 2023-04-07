-- Keep track of start time for Alpha to use later
vim.g.start_time = vim.fn.reltime()

-- Load configs for autoloaded plugins
require("nvcode.options")
require("nvcode.keymaps")
require("nvcode.notify")
require("nvcode.colorscheme")
require("nvcode.heirline")
require("nvcode.treesitter")
require("nvcode.ccc")
require("nvcode.cmp.auto")
require("nvcode.noice")
require("nvcode.zk")
require("nvcode.lazyload")
require("nvcode.alpha")
