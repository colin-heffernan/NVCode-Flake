{ pkgs, lib ? pkgs.lib, ... }: let
	inherit (pkgs) neovimPlugins;
	myNeovimUnwrapped = pkgs.neovim-unwrapped;
	nvcodeUtils = pkgs.callPackage ./utils.nix {
		# inherit (pkgs.lua51Packages) buildLuarocksPackage;
		lua = pkgs.lua5_1;
	};
	wrapNvcode = neovim-unwrapped: lib.makeOverridable (nvcodeUtils.legacyWrapper neovim-unwrapped);
	startPlugins = with pkgs.neovimPlugins; [
		plenary-nvim
		nui-nvim
		popup-nvim
		nvim-notify
		# hydra-nvim
		nvim-web-devicons
		tokyonight-nvim
		lualine-nvim
		bufferline-nvim
		# nvim-cokeline
		alpha-nvim
		neo-tree-nvim
		telescope-nvim
		# project-nvim
		# nvim-treesitter						# For building plugins from source
		# (nvim-treesitter.withPlugins (plugins: with plugins; [		# For using Nixpkgs plugins
		# 	bash
		# 	c
		# 	cpp
		# 	css
		# 	dockerfile
		# 	gdscript
		# 	# gitignore
		# 	graphql
		# 	haskell
		# 	html
		# 	javascript
		# 	json
		# 	latex
		# 	lua
		# 	markdown
		# 	nix
		# 	norg
		# 	python
		# 	regex
		# 	rust
		# 	scss
		# 	svelte
		# 	toml
		# 	typescript
		# 	vim
		# 	# yuck
		# ]))
		nvim-treesitter.withAllGrammars
		# nvim-treesitter-textobjects
		nvim-ts-autotag
		nvim-ts-context-commentstring
		ccc-nvim
		toggleterm-nvim
		nvim-cmp
		cmp-path
		# cmp-buffer
		cmp-cmdline
		noice-nvim
	];
	optPlugins = with pkgs.vimPlugins; [
		nvim-lspconfig
		null-ls-nvim
		SchemaStore-nvim
		# nvim-dap
		# nvim-dap-ui
		indent-blankline-nvim
		gitsigns-nvim
		neorg
		comment-nvim
		# twilight-nvim
		# zen-mode-nvim
		leap-nvim
		nvim-autopairs
		# trouble-nvim
		# lspsaga-nvim
		todo-comments-nvim
		friendly-snippets
		# cmp-calc
		# cmp-nvim-lsp
		luasnip
		cmp_luasnip
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
