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
		ccc-nvim
		toggleterm-nvim
		nvim-cmp
		cmp-path
		cmp-buffer
		cmp-cmdline
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
		leap-nvim
		nvim-autopairs
		trouble-nvim
		todo-comments-nvim
		friendly-snippets
		cmp-calc
		cmp-nvim-lsp
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
