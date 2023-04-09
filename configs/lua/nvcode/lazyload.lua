-- Load configs for lazyloaded plugins on BufRead and BufNewFile
local function onFileOpen()
	require("nvcode.lsp")
	require("nvcode.indentblankline")
	require("nvcode.treesitter")
	require("nvcode.gitsigns")
	require("nvcode.comment")
	require("nvcode.todo")
	require("nvcode.leap")
	require("nvcode.colorizer")
end

vim.api.nvim_create_autocmd(
	{"BufRead", "BufNewFile"},
	{
		callback = onFileOpen
	}
)

-- Load configs for lazyloaded plugins on InsertEnter
local function onInsert()
	require("nvcode.autopairs")
	require("nvcode.cmp.cmdline")
	require("nvcode.cmp.file")
end

vim.api.nvim_create_autocmd(
	{"InsertEnter"},
	{
		callback = onInsert
	}
)

-- Load configs for lazyloaded plugins on CmdlineEnter
local function onCmd()
	require("nvcode.treesitter")
	require("nvcode.cmp.cmdline")
end

vim.api.nvim_create_autocmd(
	{"CmdlineEnter"},
	{
		callback = onCmd
	}
)

-- Load configs for lazyloaded plugins on command
vim.api.nvim_create_user_command(
	"Telescope",
	function(event)
		local command = {
			cmd = "Telescope",
			bang = event.bang or nil,
			mods = event.smods,
			args = event.fargs,
			count = event.count >= 0 and event.range == 0 and event.count or nil,
		}

		if event.range == 1 then
			command.range = { event.line1 }
		elseif event.range == 2 then
			command.range = { event.line1, event.line2 }
		end

		vim.api.nvim_del_user_command("Telescope")
		require("nvcode.telescope")

		local info = vim.api.nvim_get_commands({})["Telescope"]
		command.nargs = info.nargs
		if event.args and event.args ~= "" and info.nargs and info.nargs:find("[1?]") then
			command.args = { event.args }
		end

		vim.cmd(command)
	end,
	{
		bang = true,
		range = true,
		nargs = "*",
		complete = function(_, line)
			vim.api.nvim_del_user_command("Telescope")
			require("nvcode.telescope")
			return vim.fn.getcompletion(line, "cmdline")
		end
	}
)

vim.api.nvim_create_user_command(
	"Neotree",
	function(event)
		local command = {
			cmd = "Neotree",
			bang = event.bang or nil,
			mods = event.smods,
			args = event.fargs,
			count = event.count >= 0 and event.range == 0 and event.count or nil,
		}

		if event.range == 1 then
			command.range = { event.line1 }
		elseif event.range == 2 then
			command.range = { event.line1, event.line2 }
		end

		vim.api.nvim_del_user_command("Neotree")
		require("nvcode.neotree")

		local info = vim.api.nvim_get_commands({})["Neotree"]
		command.nargs = info.nargs
		if event.args and event.args ~= "" and info.nargs and info.nargs:find("[1?]") then
			command.args = { event.args }
		end

		vim.cmd(command)
	end,
	{
		bang = true,
		range = true,
		nargs = "*",
		complete = function(_, line)
			vim.api.nvim_del_user_command("Neotree")
			require("nvcode.neotree")
			return vim.fn.getcompletion(line, "cmdline")
		end
	}
)

vim.api.nvim_create_user_command(
	"ToggleTerm",
	function(event)
		local command = {
			cmd = "ToggleTerm",
			bang = event.bang or nil,
			mods = event.smods,
			args = event.fargs,
			count = event.count >= 0 and event.range == 0 and event.count or nil,
		}

		if event.range == 1 then
			command.range = { event.line1 }
		elseif event.range == 2 then
			command.range = { event.line1, event.line2 }
		end

		vim.api.nvim_del_user_command("ToggleTerm")
		require("nvcode.toggleterm")

		local info = vim.api.nvim_get_commands({})["ToggleTerm"]
		command.nargs = info.nargs
		if event.args and event.args ~= "" and info.nargs and info.nargs:find("[1?]") then
			command.args = { event.args }
		end

		vim.cmd(command)
	end,
	{
		bang = true,
		range = true,
		nargs = "*",
		complete = function(_, line)
			vim.api.nvim_del_user_command("ToggleTerm")
			require("nvcode.toggleterm")
			return vim.fn.getcompletion(line, "cmdline")
		end
	}
)

vim.api.nvim_create_user_command(
	"Telekasten",
	function(event)
		local command = {
			cmd = "Telekasten",
			bang = event.bang or nil,
			mods = event.smods,
			args = event.fargs,
			count = event.count >= 0 and event.range == 0 and event.count or nil,
		}

		if event.range == 1 then
			command.range = { event.line1 }
		elseif event.range == 2 then
			command.range = { event.line1, event.line2 }
		end

		vim.api.nvim_del_user_command("Telekasten")
		require("nvcode.telekasten")

		local info = vim.api.nvim_get_commands({})["Telekasten"]
		command.nargs = info.nargs
		if event.args and event.args ~= "" and info.nargs and info.nargs:find("[1?]") then
			command.args = { event.args }
		end

		vim.cmd(command)
	end,
	{
		bang = true,
		range = true,
		nargs = "*",
		complete = function(_, line)
			vim.api.nvim_del_user_command("Telekasten")
			require("nvcode.telekasten")
			return vim.fn.getcompletion(line, "cmdline")
		end
	}
)
