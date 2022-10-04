local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify "CMP not found."
	return
end

local check_backspace = function()
	local col = vim.fn.col "." - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup.cmdline({ "/", "?" }, {
	mapping = {
		["<Up>"] = cmp.mapping {
			i = cmp.mapping.select_prev_item(),
			c = cmp.mapping.select_prev_item(),
		},
		["<Down>"] = cmp.mapping {
			i = cmp.mapping.select_next_item(),
			c = cmp.mapping.select_next_item(),
		},
		["<Escape>"] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		["<CR>"] = cmp.mapping {
			i = cmp.mapping.confirm { select = true },
			c = cmp.mapping.confirm { select = false },
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				buffer = "[Buffer]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "buffer" }
	}
})

cmp.setup.cmdline({ ":" }, {
	mapping = {
		["<Up>"] = cmp.mapping {
			i = cmp.mapping.select_prev_item(),
			c = cmp.mapping.select_prev_item(),
		},
		["<Down>"] = cmp.mapping {
			i = cmp.mapping.select_next_item(),
			c = cmp.mapping.select_next_item(),
		},
		["<Escape>"] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		["<CR>"] = cmp.mapping {
			i = cmp.mapping.confirm { select = true },
			c = cmp.mapping.confirm { select = false },
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				cmdline = "[Cmdline]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "cmdline" },
		{ name = "path" }
	}
})
