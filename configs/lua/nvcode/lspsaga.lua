vim.api.nvim_exec(
	[[
		packadd lspsaga-nvim
	]],
	true
)

local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
	vim.notify "LSPSaga not found."
	return
end

lspsaga.init_lsp_saga {
	code_action_icon = ""
}
