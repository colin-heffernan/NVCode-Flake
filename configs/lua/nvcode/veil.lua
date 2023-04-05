local status_ok, veil = pcall(require, "veil")
if not status_ok then
	return
end

local builtin = require("veil.builtin")

local headerFrames = {
	{
		[[███╗   ██╗ ██╗   ██╗  ██████╗  ██████╗  ██████╗  ███████╗]],
		[[████╗  ██║ ██║   ██║ ██╔════╝ ██╔═══██╗ ██╔══██╗ ██╔════╝]],
		[[██╔██╗ ██║ ██║   ██║ ██║      ██║   ██║ ██║  ██║ █████╗  ]],
		[[██║╚██╗██║ ╚██╗ ██╔╝ ██║      ██║   ██║ ██║  ██║ ██╔══╝  ]],
		[[██║ ╚████║  ╚████╔╝  ╚██████╗ ╚██████╔╝ ██████╔╝ ███████╗]],
		[[╚═╝  ╚═══╝   ╚═══╝    ╚═════╝  ╚═════╝  ╚═════╝  ╚══════╝]],
	}
}
local footerFrames = {
	{
		"NVCode loaded in " .. vim.fn.printf(
			"%i",
			vim.fn.round(vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000)
		) .. " ms."
	}
}

veil.setup {
	sections = {
		builtin.sections.animated(headerFrames),
		builtin.sections.oldfiles(),
		builtin.sections.animated(footerFrames)
	}
}
--[[ dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files hidden=true<CR>"),
	dashboard.button("o", "  Recently opened files", ":Telescope oldfiles<CR>"),
	-- dashboard.button("p", "  Recently opened projects", ":Telescope projects<CR>"),
	-- dashboard.button("n", "  New file", ":e scratch.txt<CR>"),
	-- dashboard.button("u", "  Update plugins", ":PackerSync<CR>"),
	dashboard.button("q", "  Quit NVCode", ":qa!<CR>"),
}
dashboard.section.header.opts.hl = "DashboardHeader"
dashboard.section.footer.opts.hl = "DashboardHeader"

alpha.setup(dashboard.opts) ]]
