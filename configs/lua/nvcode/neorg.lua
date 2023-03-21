vim.api.nvim_exec(
	[[
		packadd neorg
	]],
	true
)

local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
	vim.notify "Neorg not found."
	return
end

neorg.setup {
	load = {
		["core.defaults"] = {},
		["core.export"] = {},
		["core.export.markdown"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp"
			}
		},
		["core.norg.concealer"] = {
			config = {
				folds = false
			}
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					main = "~/Notes"
				},
				index = "index.norg"
			}
		},
		["core.norg.manoeuvre"] = {},
		["core.integrations.treesitter"] = {
			config = {
				configure_parsers = false,
				install_parsers = false
			}
		},
	}
}
