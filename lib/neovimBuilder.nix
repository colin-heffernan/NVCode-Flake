{ pkgs, lib ? pkgs.lib, ... }: let
	inherit (pkgs) neovimPlugins;
	myNeovimUnwrapped = pkgs.neovim-unwrapped;
	nvcodeUtils = pkgs.callPackage ./utils.nix {
		# inherit (pkgs.lua51Packages) buildLuarocksPackage;
		lua = pkgs.lua5_1;
	};
	wrapNvcode = neovim-unwrapped: lib.makeOverridable (nvcodeUtils.legacyWrapper neovim-unwrapped);
	startPlugins = with pkgs.neovimPlugins; [
		tokyonight-nvim
		nui-nvim
		plenary-nvim
		nvim-notify
		nvim-web-devicons
		heirline-nvim
		alpha-nvim
		noice-nvim
	];
	optPlugins = with pkgs.neovimPlugins; [
		nvim-ts-autotag
		nvim-ts-context-commentstring
		nvim-treesitter.withAllGrammars
		cmp-path
		cmp-buffer
		cmp-cmdline
		nvim-cmp
		popup-nvim
		neo-tree-nvim
		indent-blankline-nvim
		todo-comments-nvim
		telescope-nvim
		toggleterm-nvim
		SchemaStore-nvim
		nvim-lspconfig
		gitsigns-nvim
		comment-nvim
		leap-spooky-nvim
		leap-nvim
		nvim-autopairs
		cmp-nvim-lsp
		cmp_luasnip
		friendly-snippets
		luasnip
		mkdnflow
		nvim-colorizer-lua
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
