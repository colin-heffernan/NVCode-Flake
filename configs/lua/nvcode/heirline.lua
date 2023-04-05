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
		return { fg = colors.black, bold = true, }
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
		return { fg = self.is_active and colors.black or self.icon_color }
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
			return { fg = self.is_active and colors.black or self:mode_color() }
		end
	},
	{
		condition = function(self)
			return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
				or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
		end,
		provider = " ",
		hl = function(self)
			return { fg = self.is_active and colors.black or colors.blue }
		end
	}
}

local TablineBufferBlock = utils.surround({ "", "" }, function(self)
	return self.is_active and self:mode_color() or colors.comment
end, {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
	end,
	hl = function(self)
		return { fg = self.is_active and colors.black or colors.fg, bg = self.is_active and self:mode_color() or colors.comment }
	end,
	Space, TablineFileIcon, TablineFileName, TablineFileFlags, Space
})

local Statusline = {
	utils.surround({ "", "" }, function(self) return self:mode_color() end, { Space, ViMode, Space }),
	utils.make_buflist(
		TablineBufferBlock,
		{ provider = "", hl = { fg = colors.bg } },
		{ provider = "", hl = { fg = colors.bg } }
	),
	Align,
	static = {
		mode_colors = {
			n = colors.blue,
			no = colors.blue,
			nov = colors.blue,
			noV = colors.blue,
			["no\22"] = colors.blue,
			niI = colors.blue,
			niR = colors.blue,
			niV = colors.blue,
			nt = colors.blue,
			ntT = colors.blue,
			v = colors.magenta,
			vs = colors.magenta,
			V = colors.magenta,
			Vs = colors.magenta,
			["\22"] = colors.magenta,
			["\22s"] = colors.magenta,
			s = colors.magenta,
			S = colors.magenta,
			["\19"] = colors.magenta,
			i = colors.green,
			ic = colors.green,
			ix = colors.green,
			R = colors.red,
			Rc = colors.red,
			Rx = colors.red,
			Rv = colors.red,
			Rvc = colors.red,
			Rvx = colors.red,
			c = colors.yellow,
			cv = colors.yellow,
			ce = colors.yellow,
			r = colors.red,
			rm = colors.yellow,
			["r?"] = colors.yellow,
			["!"] = colors.yellow,
			t = colors.green1
		},
		mode_color = function(self)
			return self.mode_colors[vim.fn.mode()]
		end
	},
	hl = {
		bg = colors.black
	}
}

local GitColumn = {
	hl = function()
		local sign = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
			group = "gitsigns_vimfn_signs_",
			lnum = vim.v.lnum
		})[1]["signs"][1]
		if(sign ~= nil) then
			return {
				fg = sign.name == "GitSignsAdd" and colors.gitSigns.add
					or sign.name == "GitSignsChange" and colors.gitSigns.change
					or sign.name == "GitSignsDelete" and colors.gitSigns.delete
					or colors.comment
			}
		else
			return { fg = colors.comment }
		end
	end,
	provider = function()
		local sign = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
			group = "gitsigns_vimfn_signs_",
			lnum = vim.v.lnum
		})[1]["signs"][1]
		if(sign ~= nil) then
			return sign.name == "GitSignsAdd" and " + "
				or sign.name == "GitSignsChange" and " ~ "
				or sign.name == "GitSignsDelete" and " - "
				or "   "
		else
			return "   "
		end
	end
}

local LSPColumn = {
	hl = function()
		local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
			group = "*",
			lnum = vim.v.lnum
		})[1]["signs"]
		local diagnostic_signs = vim.tbl_filter(function(i)
			return vim.startswith(i.group, "vim.diagnostic")
		end, signs)
		local sign = diagnostic_signs[1]
		if(sign ~= nil) then
			return { fg = sign.name == "DiagnosticSignError" and colors.error
				or sign.name == "DiagnosticSignWarn" and colors.warning
				or sign.name == "DiagnosticSignInfo" and colors.info
				or sign.name == "DiagnosticSignHint" and colors.hint
				or colors.comment }
		else
			return { fg = colors.comment }
		end
	end,
	provider = function()
		local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
			group = "*",
			lnum = vim.v.lnum
		})[1]["signs"]
		local diagnostic_signs = vim.tbl_filter(function(i)
			return vim.startswith(i.group, "vim.diagnostic")
		end, signs)
		local sign = diagnostic_signs[1]
		if(sign ~= nil) then
			return sign.name == "DiagnosticSignError" and " "
				or sign.name == "DiagnosticSignWarn" and " "
				or sign.name == "DiagnosticSignInfo" and " "
				or sign.name == "DiagnosticSignHint" and " "
				or "  "
		else
			return "  "
		end
	end
}

local NumColumn = {
	Align,
	{
		provider = function()
			return vim.v.lnum
		end
	}
}

local StatusColumn = {
	condition = function()
		return not conditions.buffer_matches({
			buftype = {
				"terminal",
				"nofile",
			},
			filetype = {
				"help",
				"dashboard",
				"alpha",
				"lspinfo",
				"lsp-installer",
				"TelescopePrompt",
				"TelescopeResults",
				"packer",
				"NvimTree",
				"neo-tree",
				"norg",
			}
		})
	end,
	LSPColumn,
	Space,
	NumColumn,
	Space,
	GitColumn
}

heirline.setup {
	statusline = Statusline,
	statuscolumn = StatusColumn,
	opts = {
		colors = colors
	}
}
