vim.api.nvim_exec(
	[[
		packadd nvim-colorizer-lua
	]],
	true
)

local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	vim.notify "Colorizer not found."
	return
end

colorizer.setup {
	filetypes = {
		"*",
		"!help",
		"!dashboard",
		"!alpha",
		"!lspinfo",
		"!lsp-installer",
		"!TelescopePrompt",
		"!TelescopeResults",
		"!packer",
		"!NvimTree",
		"!neo-tree"
	},
	user_default_options = {
		RGB = true,
		RRGGBB = true,
		names = true,
		RRGGBBAA = true,
		AARRGGBB = true,
		rgb_fn = true,
		hsl_fn = true,
		css = true,
		css_fn = true,
		mode = "background",
		tailwind = true,
		sass = {
			enable = true,
			parsers = {
				"css"
			}
		},
		always_update = true
	},
	buftypes = {
		"*",
		"!prompt",
		"!popup",
		"!terminal",
		"!nofile",
	},
}
