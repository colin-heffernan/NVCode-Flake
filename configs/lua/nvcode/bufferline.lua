local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	vim.notify "Bufferline not found."
	return
end


bufferline.setup {
	options = {
		buffer_close_icon = "",
		close_icon = "",
		numbers = "buffer_id",
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
	},
}
