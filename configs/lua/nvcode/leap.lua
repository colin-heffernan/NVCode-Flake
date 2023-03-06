vim.api.nvim_exec(
	[[
		packadd leap-nvim
		packadd leap-spooky-nvim
	]],
	true
)

local status_ok, leap = pcall(require, "leap")
if not status_ok then
	vim.notify "Leap not found."
	return
end

leap.add_default_mappings()

-- Options variables
local opts = {
	noremap = true,
	silent = true
}

local keymap = vim.keymap.set

keymap("n", "s", function()
	local focusable_windows_on_tabpage = vim.tbl_filter(
		function(win) return vim.api.nvim_win_get_config(win).focusable end,
		vim.api.nvim_tabpage_list_wins(0)
	)
	leap.leap { target_windows = focusable_windows_on_tabpage }
end, opts)

local status_spooky_ok, leap_spooky = pcall(require, "leap-spooky")
if not status_ok then
	vim.notify "Leap Spooky not found."
	return
end

leap_spooky.setup {
	affixes = {
		remote = {
			window = "R",
			cross_window = "r"
		},
		magnetic = {
			window = "M",
			cross_window = "m"
		}
	}
}
