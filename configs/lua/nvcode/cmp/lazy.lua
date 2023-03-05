vim.api.nvim_exec(
	[[
		packadd friendly-snippets
		" packadd cmp-calc
		" runtime after/plugin/cmp_calc.lua
		packadd cmp-nvim-lsp
		runtime after/plugin/cmp_nvim_lsp.lua
		packadd luasnip
		packadd cmp_luasnip
		runtime after/plugin/cmp_luasnip.lua
	]],
	true
)

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify "CMP not found."
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	vim.notify "LuaSnip not found."
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

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

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
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
				nvim_lsp = "[LSP]",
				neorg = "[Neorg]",
				--[[ luasnip = "[Snippet]", ]]
				--[[ buffer = "[Buffer]", ]]
				path = "[Path]",
				--[[ calc = "[Calc]", ]]
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "neorg" },
		--[[ { name = "luasnip" }, ]]
		--[[ { name = "buffer" }, ]]
		{ name = "path" },
		--[[ { name = "calc" }, ]]
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
}
