{ pkgs, lib ? pkgs.lib, ... }: let
	neovimPlugins = pkgs.neovimPlugins;
	myNeovimUnwrapped = pkgs.neovim-unwrapped;
	nvcodeUtils = pkgs.callPackage ./utils.nix {
		# inherit (pkgs.lua51Packages) buildLuarocksPackage;
		lua = pkgs.lua5_1;
	};
	wrapNvcode = neovim-unwrapped: lib.makeOverridable (nvcodeUtils.legacyWrapper neovim-unwrapped);
	startPlugins = with pkgs.neovimPlugins; [
		neovimPlugins.plenary-nvim
		neovimPlugins.nui-nvim
		neovimPlugins.popup-nvim
		neovimPlugins.nvim-notify
		neovimPlugins.hydra-nvim
		neovimPlugins.nvim-web-devicons
		neovimPlugins.tokyonight-nvim
		neovimPlugins.lualine-nvim
		neovimPlugins.nvim-cokeline
		neovimPlugins.alpha-nvim
		neovimPlugins.neo-tree-nvim
		neovimPlugins.telescope-nvim
		neovimPlugins.project-nvim
		neovimPlugins.octo-nvim
		(vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
			bash
			c
			cpp
			css
			haskell
			html
			javascript
			json
			latex
			lua
			markdown
			markdown-inline
			nix
			norg
			python
			regex
			rust
			svelte
			typescript
			vim
		]))
		neovimPlugins.nvim-treesitter-textobjects
		neovimPlugins.nvim-ts-autotag
		neovimPlugins.nvim-ts-context-commentstring
		neovimPlugins.ccc-nvim
		neovimPlugins.toggleterm-nvim
		neovimPlugins.nvim-cmp
		neovimPlugins.cmp-path
		neovimPlugins.cmp-buffer
		neovimPlugins.cmp-cmdline
		neovimPlugins.noice-nvim
	];
	optPlugins = with pkgs; [
		neovimPlugins.nvim-lspconfig
		neovimPlugins.null-ls-nvim
		neovimPlugins.schemastore-nvim
		neovimPlugins.nvim-dap
		neovimPlugins.nvim-dap-ui
		neovimPlugins.indent-blankline-nvim
		neovimPlugins.gitsigns-nvim
		neovimPlugins.neorg
		neovimPlugins.comment-nvim
		neovimPlugins.twilight-nvim
		neovimPlugins.zen-mode-nvim
		neovimPlugins.leap-nvim
		neovimPlugins.nvim-autopairs
		neovimPlugins.trouble-nvim
		neovimPlugins.lspsaga-nvim
		neovimPlugins.todo-comments-nvim
		neovimPlugins.friendly-snippets
		neovimPlugins.cmp-calc
		neovimPlugins.cmp-nvim-lsp
		neovimPlugins.luasnip
		neovimPlugins.cmp_luasnip
	];
in wrapNvcode myNeovimUnwrapped {
	viAlias = true;
	vimAlias = true;
	configure = {
		customRC = ''
		'';
		packages.plugins = {
			start = startPlugins;
			opt = optPlugins;
		};
	};
}
