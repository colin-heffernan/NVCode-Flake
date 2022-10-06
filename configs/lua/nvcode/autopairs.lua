vim.api.nvim_exec(
	[[
		packadd nvim-autopairs
	]],
	true
)

local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	vim.notify "Autopairs not found."
	return
end
local Rule = require "nvim-autopairs.rule"
local conds = require "nvim-autopairs.conds"

npairs.setup {
	check_ts = true,
	disable_filetype = { "TelescopePrompt" }
}

npairs.add_rules {
	Rule(" ", " ")
		:with_pair(conds.before_regex("^[([{]$", 1))
		:with_pair(conds.after_regex("^[)]}]$", 1))
		:with_move(conds.after_regex("^ $"))
		:with_del(conds.before_regex("^[([{]$", 1))
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_cone", cmp_autopairs.on_confirm_done {})
