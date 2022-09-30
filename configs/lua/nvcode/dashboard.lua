vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_section = {
	a = { description = { "  Find file                           " }, command = "Telescope find_files hidden=true" },
	b = { description = { "  Recently opened files               " }, command = "Telescope oldfiles" },
	c = { description = { "  New file                            " }, command = "enew" },
	d = { description = { "  Quit Airvim                         " }, command = "qa!" },
}
vim.g.dashboard_custom_header = {
[[ ________   ___   ________   ___      ___   ___    ______ _____ ]],
[[|\   __  \ |\  \ |\   __  \ |\  \    /  /| /  /| /   _  / _   /|]],
[[\ \  \|\  \\ \  \\ \  \|\  \\ \  \  /  / //  / //  / /__///  / /]],
[[ \ \   __  \\ \  \\ \   _  _\\ \  \/  / //  / //  / |__|//  / / ]],
[[  \ \  \ \  \\ \  \\ \  \\  \|\ \    / //  / //  / /    /  / /  ]],
[[   \ \__\ \__\\ \__\\ \__\\ _\ \ \__/ //__/ //__/ /    /__/ /   ]],
[[    \|__|\|__| \|__| \|__|\|__| \|__|/ |__|/ |__|/     |__|/    ]],
}
vim.g.dashboard_custom_footer = {
	"Airvim loaded in " .. vim.fn.printf(
		"%i",
		vim.fn.round(vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000)
	) .. " ms.",
	-- "Airvim loaded in " .. vim.fn.printf(
	-- 	"%.2f",
	-- 	vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000
	-- ) .. " ms.",
}
