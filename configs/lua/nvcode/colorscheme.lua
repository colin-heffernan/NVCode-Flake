local colorscheme = "tokyonight-night"

local plugin_status_ok, tokyonight = pcall(require, "tokyonight")
if not plugin_status_ok then
	vim.notify("Tokyonight not found.")
	return
end

tokyonight.setup {
	on_highlights = function(hl, c)
		hl.TelescopeNormal = {
			bg = c.bg_dark,
			fg = c.fg_dark
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.bg_dark
		}
		hl.TelescopePromptNormal = {
			bg = c.comment
		}
		hl.TelescopePromptBorder = {
			bg = c.comment,
			fg = c.comment
		}
		hl.TelescopePromptTitle = {
			bg = c.comment,
			fg = c.comment
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark
		}
		hl.TelescopeSelection = {
			bg = c.bg_highlight
		}
		hl.NeoTreeWinSeparator = {
			fg = c.bg
		}
	end
}

local colorscheme_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_status_ok then
	vim.notify("Colorscheme " .. colorscheme .. " not found!")
	return
end
