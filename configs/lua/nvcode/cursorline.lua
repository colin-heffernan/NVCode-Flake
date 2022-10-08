-- vim.api.nvim_exec(
-- 	[[
-- 		packadd nvim-cursorline
-- 	]],
-- 	true
-- )

local status_ok, cursorline = pcall(require, "nvim-cursorline")
if not status_ok then
	vim.notify "Cursorline not found."
	return
end

cursorline.setup {
	cursorline = {
		enable = false
	},
	cursorword = {
		enable = true,
		min_length = 1,
		hl = {
			underline = false,
			--[[ link = "Visual" ]]
			bg = "#414868"
		}
	}
}
