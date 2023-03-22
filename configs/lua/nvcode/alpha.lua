local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	-- [[ ________   ___   ________   ___      ___   ___    ______ _____ ]],
	-- [[|\   __  \ |\  \ |\   __  \ |\  \    /  /| /  /| /   _  / _   /|]],
	-- [[\ \  \|\  \\ \  \\ \  \|\  \\ \  \  /  / //  / //  / /__///  / /]],
	-- [[ \ \   __  \\ \  \\ \   _  _\\ \  \/  / //  / //  / |__|//  / / ]],
	-- [[  \ \  \ \  \\ \  \\ \  \\  \|\ \    / //  / //  / /    /  / /  ]],
	-- [[   \ \__\ \__\\ \__\\ \__\\ _\ \ \__/ //__/ //__/ /    /__/ /   ]],
	-- [[    \|__|\|__| \|__| \|__|\|__| \|__|/ |__|/ |__|/     |__|/    ]],
	-- [[      ___                        ___           ___          _____          ___     ]],
	-- [[     /__/\          ___         /  /\         /  /\        /  /::\        /  /\    ]],
	-- [[     \  \:\        /__/\       /  /:/        /  /::\      /  /:/\:\      /  /:/_   ]],
	-- [[      \  \:\       \  \:\     /  /:/        /  /:/\:\    /  /:/  \:\    /  /:/ /\  ]],
	-- [[  _____\__\:\       \  \:\   /  /:/  ___   /  /:/  \:\  /__/:/ \__\:|  /  /:/ /:/_ ]],
	-- [[ /__/::::::::\  ___  \__\:\ /__/:/  /  /\ /__/:/ \__\:\ \  \:\ /  /:/ /__/:/ /:/ /\]],
	-- [[ \  \:\~~\~~\/ /__/\ |  |:| \  \:\ /  /:/ \  \:\ /  /:/  \  \:\  /:/  \  \:\/:/ /:/]],
	-- [[  \  \:\  ~~~  \  \:\|  |:|  \  \:\  /:/   \  \:\  /:/    \  \:\/:/    \  \::/ /:/ ]],
	-- [[   \  \:\       \  \:\__|:|   \  \:\/:/     \  \:\/:/      \  \::/      \  \:\/:/  ]],
	-- [[    \  \:\       \__\::::/     \  \::/       \  \::/        \__\/        \  \::/   ]],
	-- [[     \__\/           ~~~~       \__\/         \__\/                       \__\/    ]],
	-- [[  /\\\\\     /\\\  /\\\        /\\\        /\\\\\\\\\       /\\\\\       /\\\\\\\\\\\\     /\\\\\\\\\\\\\\\         ]],
	-- [[  \/\\\\\\   \/\\\ \/\\\       \/\\\     /\\\////////      /\\\///\\\    \/\\\////////\\\  \/\\\///////////         ]],
	-- [[   \/\\\/\\\  \/\\\ \//\\\      /\\\    /\\\/             /\\\/  \///\\\  \/\\\      \//\\\ \/\\\                   ]],
	-- [[    \/\\\//\\\ \/\\\  \//\\\    /\\\    /\\\              /\\\      \//\\\ \/\\\       \/\\\ \/\\\\\\\\\\\          ]],
	-- [[     \/\\\\//\\\\/\\\   \//\\\  /\\\    \/\\\             \/\\\       \/\\\ \/\\\       \/\\\ \/\\\///////          ]],
	-- [[      \/\\\ \//\\\/\\\    \//\\\/\\\     \//\\\            \//\\\      /\\\  \/\\\       \/\\\ \/\\\                ]],
	-- [[       \/\\\  \//\\\\\\     \//\\\\\       \///\\\           \///\\\  /\\\    \/\\\       /\\\  \/\\\               ]],
	-- [[        \/\\\   \//\\\\\      \//\\\          \////\\\\\\\\\    \///\\\\\/     \/\\\\\\\\\\\\/   \/\\\\\\\\\\\\\\\  ]],
	-- [[         \///     \/////        \///              \/////////       \/////       \////////////     \///////////////  ]],
	[[███╗   ██╗ ██╗   ██╗  ██████╗  ██████╗  ██████╗  ███████╗]],
	[[████╗  ██║ ██║   ██║ ██╔════╝ ██╔═══██╗ ██╔══██╗ ██╔════╝]],
	[[██╔██╗ ██║ ██║   ██║ ██║      ██║   ██║ ██║  ██║ █████╗  ]],
	[[██║╚██╗██║ ╚██╗ ██╔╝ ██║      ██║   ██║ ██║  ██║ ██╔══╝  ]],
	[[██║ ╚████║  ╚████╔╝  ╚██████╗ ╚██████╔╝ ██████╔╝ ███████╗]],
	[[╚═╝  ╚═══╝   ╚═══╝    ╚═════╝  ╚═════╝  ╚═════╝  ╚══════╝]],
}
dashboard.section.footer.val = {
	"NVCode loaded in " .. vim.fn.printf(
		"%i",
		vim.fn.round(vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000)
	) .. " ms.",
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files hidden=true<CR>"),
	dashboard.button("o", "  Recently opened files", ":Telescope oldfiles<CR>"),
	-- dashboard.button("p", "  Recently opened projects", ":Telescope projects<CR>"),
	-- dashboard.button("n", "  New file", ":e scratch.txt<CR>"),
	dashboard.button("n", "󰠮  Open notes", ":ZkTags<CR>"),
	-- dashboard.button("u", "  Update plugins", ":PackerSync<CR>"),
	dashboard.button("q", "  Quit NVCode", ":qa!<CR>"),
}
dashboard.section.header.opts.hl = "DashboardHeader"
dashboard.section.footer.opts.hl = "DashboardHeader"

alpha.setup(dashboard.opts)
