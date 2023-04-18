local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
	return
end

dashboard.setup {
	theme = "hyper",
	disable_move = false,
	shortcut_type = "letter",
	change_to_vcs_root = false,
	config = {
		header = {
			[[███╗   ██╗ ██╗   ██╗  ██████╗  ██████╗  ██████╗  ███████╗]],
			[[████╗  ██║ ██║   ██║ ██╔════╝ ██╔═══██╗ ██╔══██╗ ██╔════╝]],
			[[██╔██╗ ██║ ██║   ██║ ██║      ██║   ██║ ██║  ██║ █████╗  ]],
			[[██║╚██╗██║ ╚██╗ ██╔╝ ██║      ██║   ██║ ██║  ██║ ██╔══╝  ]],
			[[██║ ╚████║  ╚████╔╝  ╚██████╗ ╚██████╔╝ ██████╔╝ ███████╗]],
			[[╚═╝  ╚═══╝   ╚═══╝    ╚═════╝  ╚═════╝  ╚═════╝  ╚══════╝]],
		},
		week_header = {
			enable = false
		},
		disable_move = false,
		footer = {
			"NVCode loaded in " .. vim.fn.printf(
				"%i",
				vim.fn.round(vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000)
			) .. " ms.",
		}
	},
	hide = {
		statusline = false,
		tabline = false,
		winbar = false
	},
}
