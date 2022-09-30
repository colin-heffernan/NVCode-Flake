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
		["core.autocommands"] = {},
		["core.norg.esupports.metagen"] = {
			config = {
				type = "auto"
			}
		},
		["core.keybinds"] = {},
		["core.norg.qol.todo_items"] = {
			config = {
				order = {
					{ "cancelled", "_" },
					{ "undone", " " },
					{ "pending", "-" },
					{ "done", "x" },
					{ "on_hold", "=" },
					{ "important", "!" },
				}
			}
		},
		["core.syntax"] = {},
		["core.tangle"] = {},
		["core.neorgcmd"] = {},
		["core.mode"] = {},
		["core.norg.esupports.indent"] = {},
		["core.integrations.treesitter"] = {
			config = {
				configure_parsers = false,
				install_parsers = false
			}
		},
		["core.presenter"] = {
			config = {
				zen_mode = "zen-mode"
			}
		},
		["core.norg.qol.toc"] = {},
		["core.norg.concealer"] = {
			config = {
				folds = false
			}
		},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp"
			}
		},
		["core.export"] = {},
		["core.export.markdown"] = {},
		["core.ui"] = {},
		["core.queries.native"] = {},
		["core.integrations.nvim-cmp"] = {},
		["core.highlights"] = {}
	}
}
