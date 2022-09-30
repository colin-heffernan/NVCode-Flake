vim.api.nvim_exec(
	[[
		packadd twilight-nvim
		packadd zen-mode-nvim
	]],
	true
)

local twilight_status_ok, twilight = pcall(require, "twilight")
if not twilight_status_ok then
	vim.notify "Twilight not found."
	return
end

local zen_status_ok, zenmode = pcall(require, "zen-mode")
if not zen_status_ok then
	vim.notify "Zen Mode not found."
	return
end

twilight.setup {
}

zenmode.setup {
	window = {
		backdrop = 1;
		width = 1;
	}
}
