{ pkgs, lib ? pkgs.lib, ... }: let
	neovimPlugins = pkgs.neovimPlugins;
	myNeovimUnwrapped = pkgs.neovim-unwrapped;
	nvcodeUtils = pkgs.callPackage ./utils.nix {
		inherit (pkgs.lua51Packages) buildLuarocksPackage;
	};
	wrapNvcode = neovim-unwrapped: lib.makeOverridable (nvcodeUtils.legacyWrapper neovim-unwrapped);
	startPlugins = with pkgs.neovimPlugins; [
		plenary-nvim
		nui-nvim
		popup-nvim
		nvim-notify
		hydra-nvim
		nvim-web-devicons
		tokyonight-nvim
		lualine-nvim
		nvim-cokeline
		alpha-nvim
		neo-tree-nvim
		telescope-nvim
		project-nvim
		octo-nvim
		nvim-treesitter
		nvim-treesitter-textobjects
		nvim-ts-autotag
		nvim-ts-context-commentstring
		toggleterm-nvim
		friendly-snippets
		nvim-cmp
		cmp-path
		cmp-calc
		cmp-nvim-lsp
		cmp-buffer
		luasnip
		cmp_luasnip
		noice-nvim
	];
	optPlugins = with pkgs.neovimPlugins; [
		nvim-lspconfig
		null-ls-nvim
		schemastore-nvim
		nvim-dap
		nvim-dap-ui
		indent-blankline-nvim
		gitsigns-nvim
		neorg
		comment-nvim
		twilight-nvim
		zen-mode-nvim
		nvim-colorizer-lua
		ccc-nvim
		leap-nvim
		nvim-autopairs
		trouble-nvim
		todo-comments-nvim
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
