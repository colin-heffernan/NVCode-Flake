local status_ok, veil = pcall(require, "veil")
if not status_ok then
	return
end

local builtin = require("veil.builtin")

local headerFrames = {
	-- {
	-- 	[[███╗   ██╗ ██╗   ██╗  ██████╗  ██████   ██████   ███████ ]],
	-- 	[[████╗  ██║ ██║   ██║ ██╔════╝ ██    ██  ██   ██  ██      ]],
	-- 	[[██╔██╗ ██║ ██║   ██║ ██║      ██    ██  ██   ██  █████   ]],
	-- 	[[██║╚██╗██║ ╚██╗ ██╔╝ ██║      ██    ██  ██   ██  ██      ]],
	-- 	[[██║ ╚████║  ╚████╔╝  ╚██████╗  ██████   ██████   ███████ ]],
	-- 	[[╚═╝  ╚═══╝   ╚═══╝    ╚═════╝                            ]],
	-- },
	-- {
	-- 	[[███    ██  ██╗   ██╗  ██████╗  ██████╗  ██████   ███████ ]],
	-- 	[[████   ██  ██║   ██║ ██╔════╝ ██╔═══██╗ ██   ██  ██      ]],
	-- 	[[██ ██  ██  ██║   ██║ ██║      ██║   ██║ ██   ██  █████   ]],
	-- 	[[██  ██ ██  ╚██╗ ██╔╝ ██║      ██║   ██║ ██   ██  ██      ]],
	-- 	[[██   ████   ╚████╔╝  ╚██████╗ ╚██████╔╝ ██████   ███████ ]],
	-- 	[[             ╚═══╝    ╚═════╝  ╚═════╝                   ]],
	-- },
	-- {
	-- 	[[███    ██  ██    ██   ██████╗  ██████╗  ██████╗  ███████ ]],
	-- 	[[████   ██  ██    ██  ██╔════╝ ██╔═══██╗ ██╔══██╗ ██      ]],
	-- 	[[██ ██  ██  ██    ██  ██║      ██║   ██║ ██║  ██║ █████   ]],
	-- 	[[██  ██ ██   ██  ██   ██║      ██║   ██║ ██║  ██║ ██      ]],
	-- 	[[██   ████    ████    ╚██████╗ ╚██████╔╝ ██████╔╝ ███████ ]],
	-- 	[[                      ╚═════╝  ╚═════╝  ╚═════╝          ]],
	-- },
	-- {
	-- 	[[███    ██  ██    ██   ██████   ██████╗  ██████╗  ███████╗]],
	-- 	[[████   ██  ██    ██  ██       ██╔═══██╗ ██╔══██╗ ██╔════╝]],
	-- 	[[██ ██  ██  ██    ██  ██       ██║   ██║ ██║  ██║ █████╗  ]],
	-- 	[[██  ██ ██   ██  ██   ██       ██║   ██║ ██║  ██║ ██╔══╝  ]],
	-- 	[[██   ████    ████     ██████  ╚██████╔╝ ██████╔╝ ███████╗]],
	-- 	[[                               ╚═════╝  ╚═════╝  ╚══════╝]],
	-- },
	-- {
	-- 	[[███╗   ██╗ ██    ██   ██████   ██████   ██████╗  ███████╗]],
	-- 	[[████╗  ██║ ██    ██  ██       ██    ██  ██╔══██╗ ██╔════╝]],
	-- 	[[██╔██╗ ██║ ██    ██  ██       ██    ██  ██║  ██║ █████╗  ]],
	-- 	[[██║╚██╗██║  ██  ██   ██       ██    ██  ██║  ██║ ██╔══╝  ]],
	-- 	[[██║ ╚████║   ████     ██████   ██████   ██████╔╝ ███████╗]],
	-- 	[[╚═╝  ╚═══╝                              ╚═════╝  ╚══════╝]],
	-- },
	-- {
	-- 	[[███╗   ██╗ ██╗   ██╗  ██████   ██████   ██████   ███████╗]],
	-- 	[[████╗  ██║ ██║   ██║ ██       ██    ██  ██   ██  ██╔════╝]],
	-- 	[[██╔██╗ ██║ ██║   ██║ ██       ██    ██  ██   ██  █████╗  ]],
	-- 	[[██║╚██╗██║ ╚██╗ ██╔╝ ██       ██    ██  ██   ██  ██╔══╝  ]],
	-- 	[[██║ ╚████║  ╚████╔╝   ██████   ██████   ██████   ███████╗]],
	-- 	[[╚═╝  ╚═══╝   ╚═══╝                               ╚══════╝]],
	-- }
	{
		[[███╗   ██╗ ██╗   ██╗  ██████╗  ██████╗  ██████╗  ███████╗]],
		[[████╗  ██║ ██║   ██║ ██╔════╝ ██╔═══██╗ ██╔══██╗ ██╔════╝]],
		[[██╔██╗ ██║ ██║   ██║ ██║      ██║   ██║ ██║  ██║ █████╗  ]],
		[[██║╚██╗██║ ╚██╗ ██╔╝ ██║      ██║   ██║ ██║  ██║ ██╔══╝  ]],
		[[██║ ╚████║  ╚████╔╝  ╚██████╗ ╚██████╔╝ ██████╔╝ ███████╗]],
		[[╚═╝  ╚═══╝   ╚═══╝    ╚═════╝  ╚═════╝  ╚═════╝  ╚══════╝]]
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
		builtin.sections.animated(headerFrames, {}),
		builtin.sections.oldfiles(),
		builtin.sections.buttons({
			{
				icon = "",
				text = "Quit NVCode",
				shortcut = "q",
				callback = ":qa!<CR>"

			}
		}),
		builtin.sections.animated(footerFrames, {})
	},
	startup = true
}
