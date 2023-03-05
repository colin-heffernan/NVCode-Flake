local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	vim.notify "Bufferline not found."
	return
end


bufferline.setup {
	options = {
		numbers = "none",
		indicator = {
			style = "none"
		},
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		offsets = { { filetype = "neo-tree", text = "", padding = 0 } },
		show_buffer_close_icons = false,
		show_close_icon = false,
		separator_style = "thick",
		always_show_bufferline = true,
	},
}
