vim.api.nvim_exec(
	[[
		packadd nvim-dap
		packadd nvim-dap-ui
	]],
	true
)

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

dap.adapters = {
	haskell = {
		type = "executable";
		command = "haskell-debug-adapter";
		args = { "--hackage-version=0.0.33.0" };
	},
	python = {
		type = "executable";
		command = "python";
		args = { "-m", "debugpy.adapter" };
	}
}

dap.configurations = {
	haskell = {
		{
			type = "haskell";
			request = "launch";
			name = "Debug";
			workspace = '${workspaceFolder}',
			startup = "${file}",
			stopOnEntry = true,
			logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
			logLevel = 'WARNING',
			ghciEnv = vim.empty_dict(),
			ghciPrompt = "λ: ",
			ghciInitialPrompt = "λ: ",
			ghciCmd= "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
		}
	},
	python = {
		{
			type = "python";
			request = "launch";
			name = "Launch file";
			program = "${file}";
		}
	}
}

dapui.setup {
	--[[ layouts = { ]]
	--[[ 	{ ]]
	--[[ 		elements = { ]]
	--[[ 			{ ]]
	--[[ 				id = "scopes", ]]
	--[[ 				size = 0.25 ]]
	--[[ 			}, ]]
	--[[ 			{ ]]
	--[[ 				id = "breakpoints", ]]
	--[[ 				size = 0.25 ]]
	--[[ 			} ]]
	--[[ 		}, ]]
	--[[ 		size = 40, ]]
	--[[ 		position = "right" ]]
	--[[ 	} ]]
	--[[ } ]]
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
