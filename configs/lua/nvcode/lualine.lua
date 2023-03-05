local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify "Lualine not found."
	return
end
local colors_status_ok, tncolors = pcall(require, "tokyonight.colors")
if colors_status_ok then
	local colors = tncolors.setup({ transform = true })
	local function process_sections(sections)
		for name, section in pairs(sections) do
			local left = name:sub(9, 10) < 'x'
			for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
				table.insert(section, pos * 2, { empty, color = { fg = colors.bg_statusline, bg = colors.bg_statusline } })
			end
			for id, comp in ipairs(section) do
				if type(comp) ~= 'table' then
					comp = { comp }
					section[id] = comp
				end
				comp.separator = left and { right = '' } or { left = '' }
			end
		end
		return sections
	end
	lualine.setup {
		options = {
			component_separators = '',
			section_separators = { left = '', right = '' },
			globalstatus = true
		},
		sections = process_sections {
			lualine_a = {"mode"},
			lualine_b = {"filetype"},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {"diagnostics"},
			lualine_z = {"branch"}
		}
	}
else
	lualine.setup {
		options = {
			component_separators = '',
			section_separators = { left = '', right = '' },
			globalstatus = true
		},
		sections = {
			lualine_a = {"mode"},
			lualine_b = {"filetype"},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {"diagnostics"},
			lualine_z = {"branch", "diff"}
		}
	}
end

