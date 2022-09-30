local status_ok, cokeline = pcall(require, "cokeline")
if not status_ok then
	vim.notify "Bufferline not found."
	return
end

local get_hex = require("cokeline/utils").get_hex
local green = vim.g.terminal_color_2

local components = {
	devicon = {
		text = function(buffer)
			return " " .. buffer.devicon.icon .. " "
		end,
		fg = function(buffer)
			return buffer.devicon.color
		end
	},
	filepath = {
		text = function(buffer)
			return buffer.unique_prefix
		end
	},
	filename = {
		text = function(buffer)
			return buffer.filename
		end,
		style = function(buffer)
			return buffer.is_focused and "bold" or nil
		end
	},
	modifiedIndicator = {
		text = function(buffer)
			return buffer.is_modified and " ● " or " "
		end,
		fg = function(buffer)
			return buffer.is_modified and green or nil
		end
	}
}

cokeline.setup {
	default_hl = {
		fg = function(buffer)
			return
				buffer.is_focused
				and get_hex("Normal", "fg")
				or get_hex("Comment", "fg")
		end,
		bg = function(buffer)
			return
				buffer.is_focused
				and "NONE"
				or get_hex("ColorColumn", "bg")
		end
	},
	sidebar = {
		filetype = "neo-tree",
		components = {
			{
				text = "",
				bg = get_hex("ColorColumn", "bg")
			}
		}
	},
	components = {
		components.devicon,
		components.filepath,
		components.filename,
		components.modifiedIndicator
	}
}
