local status_ok, noice = pcall(require, "noice")
if not status_ok then
	vim.notify "Noice not found."
	return
end

noice.setup {
	views = {
		cmdline_popup = {
			border = {
				style = "none",
				padding = { 1, 2 }
			},
			filter_options = {},
			win_options = {
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
			}
		}
	}
}
