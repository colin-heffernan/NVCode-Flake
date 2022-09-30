local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
	vim.notify "Project not found."
	return
end

project.setup {
}
