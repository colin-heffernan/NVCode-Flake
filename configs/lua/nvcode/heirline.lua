local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	vim.notify "Heirline not found."
	return
end

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors_status_ok, tncolors = pcall(require, "tokyonight.colors")
if not colors_status_ok then
	vim.notify "Colors for Heirline not found."
	return
end

local icons_status_ok, icons = pcall(require, "nvim-web-devicons")
if not icons_status_ok then
	vim.notify "Icons for Heirline not found."
	return
end

local colors = tncolors.setup({ transform = true })

local Align = { provider = "%=" }
local Space = { provider = " " }

local ViMode = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	static = {
		mode_names = {
			n = "N",
			no = "N",
			nov = "N",
			noV = "N",
			["no\22"] = "N",
			niI = "N",
			niR = "N",
			niV = "N",
			nt = "N",
			ntT = "N",
			v = "V",
			vs = "V",
			V = "V",
			Vs = "V",
			["\22"] = "V",
			["\22s"] = "V",
			s = "S",
			S = "S",
			["\19"] = "S",
			i = "I",
			ic = "I",
			ix = "I",
			R = "R",
			Rc = "R",
			Rx = "R",
			Rv = "R",
			Rvc = "R",
			Rvx = "R",
			c = "C",
			cv = "X",
			ce = "X",
			r = "R",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "T",
		}
	},
	provider = function(self)
		return self.mode_names[self.mode]
	end,
	hl = function(self)
		return { fg = "black", bold = true, }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	}
}

local TablineFileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color = icons.get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.is_active and "black" or self.icon_color }
	end
}

local TablineFileName = {
	provider = function(self)
		local filename = self.filename
		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		return { bold = self.active }
	end
}

local TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_buf_get_option(self.bufnr, "modified")
		end,
		provider = " ",
		hl = function(self)
			return { fg = self.is_active and "black" or self:mode_color() }
		end
	},
	{
		condition = function(self)
			return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
				or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
		end,
		provider = " ",
		hl = function(self)
			return { fg = self.is_active and "black" or "blue" }
		end
	}
}

local TablineBufferBlock = utils.surround({ "", "" }, function(self)
	return self.is_active and self:mode_color() or "comment"
end, {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
	end,
	hl = function(self)
		return { fg = self.is_active and "black" or "fg", bg = self.is_active and self:mode_color() or "comment" }
	end,
	Space, TablineFileIcon, TablineFileName, TablineFileFlags, Space
})

local Statusline = {
	utils.surround({ "", "" }, function(self) return self:mode_color() end, { Space, ViMode, Space }),
	utils.make_buflist(
		TablineBufferBlock,
		{ provider = "", hl = { fg = "bg" } },
		{ provider = "", hl = { fg = "bg" } }
	),
	Align,
	static = {
		mode_colors = {
			n = "blue",
			no = "blue",
			nov = "blue",
			noV = "blue",
			["no\22"] = "blue",
			niI = "blue",
			niR = "blue",
			niV = "blue",
			nt = "blue",
			ntT = "blue",
			v = "magenta",
			vs = "magenta",
			V = "magenta",
			Vs = "magenta",
			["\22"] = "magenta",
			["\22s"] = "magenta",
			s = "magenta",
			S = "magenta",
			["\19"] = "magenta",
			i = "green",
			ic = "green",
			ix = "green",
			R = "red",
			Rc = "red",
			Rx = "red",
			Rv = "red",
			Rvc = "red",
			Rvx = "red",
			c = "yellow",
			cv = "yellow",
			ce = "yellow",
			r = "red",
			rm = "yellow",
			["r?"] = "yellow",
			["!"] = "yellow",
			t = "green1"
		},
		mode_color = function(self)
			return self.mode_colors[vim.fn.mode()]
		end
	},
	hl = {
		bg = "black"
	}
}

local GitColumn = {
	hl = function()
		local sign = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
			group = "gitsigns_vimfn_signs_",
			--[[ id = vim.v.lnum, ]]
			lnum = vim.v.lnum
		})
		return { fg = sign ~= nil and sign.name or "red" }
	end,
	provider = function()
		local sign = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
			group = "gitsigns_vimfn_signs_",
			--[[ id = vim.v.lnum, ]]
			lnum = vim.v.lnum
		})
		return sign ~= nil and " ▏" or "  "
		--[[ return sign ~= nil and sign or "  " ]]
		--[[ return sign.name ]]
	end,
	--[[ provider = " ▏" ]]
}

local LSPColumn = {
	Align,
	{
		provider = "%s"
	},
	Space
}

local NumColumn = {
	Align,
	{
		provider = "%l"
	},
	Space
}

local StatusColumn = {
	LSPColumn,
	NumColumn,
	--[[ GitColumn, ]]
}

heirline.setup {
	statusline = Statusline,
	statuscolumn = StatusColumn,
	opts = {
		colors = colors
	}
}
