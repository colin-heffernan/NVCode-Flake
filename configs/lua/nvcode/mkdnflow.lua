vim.api.nvim_exec(
	[[
		packadd mkdnflow
	]],
	true
)

local status_ok, mkdnflow = pcall(require, "mkdnflow")
if not status_ok then
	vim.notify "Mkdnflow not found."
	return
end

mkdnflow.setup {
	modules = {
		bib = false,
		buffers = false,
		conceal = true,
		cursor = false,
		folds = false,
		links = true,
		lists = true,
		maps = true,
		paths = true,
		tables = true,
		yaml = false
	},
	create_dirs = false,
	perspective = {
		priority = "current",
		fallback = "root",
		root_tell = "README.md",
		nvim_md_heel = false,
		update = false
	},
	wrap = false,
	bib = {
		default_path = nil,
		find_in_root = false
	},
	silent = true,
	links = {
		style = "markdown",
		name_is_source = false,
		conceal = true,
		context = 0,
		implicit_extension = "md",
		transform_explicit = false,
		transform_implicit = false
	},
	tables = {
		trim_whitespace = true,
		format_on_move = true,
		auto_extend_rows = true,
		auto_extend_cols = true
	},
	yaml = {
		bib = {
			override = false
		}
	},
	mappings = {
		MkdnEnter = false,
		MkdnTab = false,
		MkdnSTab = false,
		MkdnNextLink = false,
		MkdnPrevLink = false,
		MkdnNextHeading = false,
		MkdnPrevHeading = false,
		MkdnGoBack = false,
		MkdnGoForward = false,
		MkdnCreateLink = false, -- see MkdnEnter
		MkdnCreateLinkFromClipboard = false, -- see MkdnEnter
		MkdnFollowLink = {"n", "<CR>"},
		MkdnDestroyLink = false,
		MkdnTagSpan = false,
		MkdnMoveSource = false,
		MkdnYankAnchorLink = false,
		MkdnYankFileAnchorLink = false,
		MkdnIncreaseHeading = false,
		MkdnDecreaseHeading = false,
		MkdnToggleToDo = {{"n"}, "<C-Space>"},
		MkdnNewListItem = false,
		MkdnNewListItemBelowInsert = {"n", "o"},
		MkdnNewListItemAboveInsert = {"n", "O"},
		MkdnExtendList = false,
		MkdnUpdateNumbering = false,
		MkdnTableNextCell = false,
		MkdnTablePrevCell = false,
		MkdnTableNextRow = false,
		MkdnTablePrevRow = false,
		MkdnTableNewRowBelow = false,
		MkdnTableNewRowAbove = false,
		MkdnTableNewColAfter = false,
		MkdnTableNewColBefore = false,
		MkdnFoldSection = false,
		MkdnUnfoldSection = false
	}
}
