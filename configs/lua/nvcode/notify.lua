local status_ok, notify = pcall(require, "notify")
if not status_ok then
	vim.notify "Notify not found."
	return
end

vim.notify = notify

notify.setup {
	stages = "slide",
}
