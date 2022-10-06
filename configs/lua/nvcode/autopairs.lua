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

npairs.setup {
	check_ts = true,
	disable_filetype = { "TelescopePrompt" }
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_cone", cmp_autopairs.on_confirm_done {})
