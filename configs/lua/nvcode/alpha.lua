local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local header = {
	type = "text",
	val = {
		[[███╗   ██╗ ██╗   ██╗  ██████╗  ██████╗  ██████╗  ███████╗]],
		[[████╗  ██║ ██║   ██║ ██╔════╝ ██╔═══██╗ ██╔══██╗ ██╔════╝]],
		[[██╔██╗ ██║ ██║   ██║ ██║      ██║   ██║ ██║  ██║ █████╗  ]],
		[[██║╚██╗██║ ╚██╗ ██╔╝ ██║      ██║   ██║ ██║  ██║ ██╔══╝  ]],
		[[██║ ╚████║  ╚████╔╝  ╚██████╗ ╚██████╔╝ ██████╔╝ ███████╗]],
		[[╚═╝  ╚═══╝   ╚═══╝    ╚═════╝  ╚═════╝  ╚═════╝  ╚══════╝]],
		-- [[    /--/           /--|     /--/ |--|     /--/  \--\    ]],
		-- [[   /::/           /:::|    /::/  |::|    /::/    \::\   ]],
		-- [[  /::/           /::::|   /::/   |::|   /::/      \::\  ]],
		-- [[ /::/           /::|::|  /::/    |::|  /::/        \::\ ]],
		-- [[/::/           /::/|::| /::/     |::| /::/          \::\]],
		-- [[\::\          /::/ |::|/::/      |::|/::/           /::/]],
		-- [[ \::\        /::/  |::|::/       |::|::/           /::/ ]],
		-- [[  \::\      /::/   |::::/        |::::/           /::/  ]],
		-- [[   \::\    /::/    |:::/         |:::/           /::/   ]],
		-- [[    \--\  /--/     |--/          |--/           /--/    ]]
	},
	opts = {
		position = "center",
		hl = "DashboardHeader"
	}
}

local footer = {
	type = "text",
	val = {
		"NVCode loaded in " .. vim.fn.printf(
			"%i",
			vim.fn.round(vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000)
		) .. " ms.",
	},
	opts = {
		position = "center",
		hl = "DashboardHeader"
	}
}

local opts = {
	noremap = true,
	silent = true,
	buffer = true
}

vim.keymap.set("n", "q", ":q<CR>", opts)

local shortcuts = {
	type = "text",
	val = {
		" Quit NVCode [q]"
	},
	opts = {
		position = "center",
		hl = "DashboardHeader"
	}
}

local if_nil = vim.F.if_nil
local fnamemodify = vim.fn.fnamemodify
local filereadable = vim.fn.filereadable

local leader = "SPC"

local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

	local opts = {
		position = "center",
		shortcut = "[" .. sc .. "] ",
		cursor = 1,
		width = 80,
		align_shortcut = "right",
		hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
		shrink_margin = false,
	}
	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

local nvim_web_devicons = {
	enabled = true,
	highlight = true,
}

local function get_extension(fn)
	local match = fn:match("^.+(%..+)$")
	local ext = ""
	if match ~= nil then
		ext = match:sub(2)
	end
	return ext
end

local function icon(fn)
	local nwd = require("nvim-web-devicons")
	local ext = get_extension(fn)
	return nwd.get_icon(fn, ext, { default = true })
end

local function file_button(fn, sc, short_fn, autocd)
	short_fn = if_nil(short_fn, fn)
	local ico_txt
	local fb_hl = {}
	if nvim_web_devicons.enabled then
		local ico, hl = icon(fn)
		local hl_option_type = type(nvim_web_devicons.highlight)
		if hl_option_type == "boolean" then
			if hl and nvim_web_devicons.highlight then
				table.insert(fb_hl, { hl, 0, #ico })
			end
		end
		if hl_option_type == "string" then
			table.insert(fb_hl, { nvim_web_devicons.highlight, 0, #ico })
		end
		ico_txt = ico .. "  "
	else
		ico_txt = ""
	end
	local cd_cmd = (autocd and " | cd %:p:h" or "")
	local file_button_el = button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. cd_cmd .." <CR>")
	local fn_start = short_fn:match(".*[/\\]")
	if fn_start ~= nil then
		table.insert(fb_hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
	end
	file_button_el.opts.hl = fb_hl
	return file_button_el
end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
	ignore = function(path, ext)
		return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
	end,
	autocd = false
}

local function mru_func(start, cwd, items_number, opts)
	opts = opts or mru_opts
	items_number = if_nil(items_number, 10)
	local oldfiles = {}
	for _, v in pairs(vim.v.oldfiles) do
		if #oldfiles == items_number then
			break
		end
		local cwd_cond
		if not cwd then
			cwd_cond = true
		else
			cwd_cond = vim.startswith(v, cwd)
		end
		local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
		if (filereadable(v) == 1) and cwd_cond and not ignore then
			oldfiles[#oldfiles + 1] = v
		end
	end

	local tbl = {}
	for i, fn in ipairs(oldfiles) do
		local short_fn
		if cwd then
			short_fn = fnamemodify(fn, ":.")
		else
			short_fn = fnamemodify(fn, ":~")
		end
		local file_button_el = file_button(fn, tostring(i + start - 1), short_fn,opts.autocd)
		tbl[i] = file_button_el
	end
	return {
		type = "group",
		val = tbl,
		opts = {},
	}
end

local mru = {
	type = "group",
	val = function()
		return { mru_func(0) }
	end,
	opts = {
		position = "center"
	}
}

--[[ dashboard.buttons.val = {
	buttons.button("f", "  Find file", ":Telescope find_files hidden=true<CR>"),
	buttons.button("o", "  Recently opened files", ":Telescope oldfiles<CR>"),
	-- dashboard.button("p", "  Recently opened projects", ":Telescope projects<CR>"),
	-- dashboard.button("n", "  New file", ":e scratch.txt<CR>"),
	-- dashboard.button("n", "󰠮  Open notes", ":Telekasten show_tags<CR>"),
	-- dashboard.button("u", "  Update plugins", ":PackerSync<CR>"),
	buttons.button("q", "  Quit NVCode", ":qa!<CR>"),
} ]]

local config = {
	layout = {
		{ type = "padding", val = 2 },
		header,
		{ type = "padding", val = 1 },
		shortcuts,
		{ type = "padding", val = 1 },
		mru,
		{ type = "padding", val = 1 },
		footer
	},
	opts = {
		margin = 5
	}
}

alpha.setup(config)
