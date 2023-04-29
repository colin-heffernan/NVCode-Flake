{
	description = "NVCode Flake";

	inputs = {
		##### General Inputs
		# Nixpkgs
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# Neovim Nightly
		neovim-nightly = {
			url = "github:neovim/neovim?dir=contrib";
			# url = "github:neovim/neovim?dir=contrib&rev=eac75a971d042bd610310314e6c64097694ee418";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		##### Plugins
		# Plenary
		plenary-nvim = {
			url = "github:nvim-lua/plenary.nvim";
			flake = false;
		};

		# NUI
		nui-nvim = {
			url = "github:MunifTanjim/nui.nvim";
			flake = false;
		};

		# Popup
		popup-nvim = {
			url = "github:nvim-lua/popup.nvim";
			flake = false;
		};

		# Notify
		nvim-notify = {
			url = "github:rcarriga/nvim-notify";
			flake = false;
		};

		# Icons
		nvim-web-devicons = {
			url = "github:kyazdani42/nvim-web-devicons";
			flake = false;
		};

		# UI
		tokyonight-nvim = {
			url = "github:folke/tokyonight.nvim";
			flake = false;
		};
		heirline-nvim = {
			url = "github:rebelot/heirline.nvim";
			flake = false;
		};
		alpha-nvim = {
			url = "github:goolord/alpha-nvim";
			flake = false;
		};
		noice-nvim = {
			url = "github:folke/noice.nvim";
			flake = false;
		};

		# File exploration
		neo-tree-nvim = {
			url = "github:nvim-neo-tree/neo-tree.nvim/v2.x";
			flake = false;
		};
		telescope-nvim = {
			url = "github:nvim-telescope/telescope.nvim";
			flake = false;
		};

		# Terminal
		toggleterm-nvim = {
			url = "github:akinsho/toggleterm.nvim";
			flake = false;
		};

		# Language support
		nvim-lspconfig = {
			url = "github:neovim/nvim-lspconfig";
			flake = false;
		};
		SchemaStore-nvim = {
			url = "github:b0o/SchemaStore.nvim";
			flake = false;
		};
		nvim-treesitter = {
			url = "github:nvim-treesitter/nvim-treesitter";
			flake = false;
		};

		# Completion
		nvim-cmp = {
			url = "github:hrsh7th/nvim-cmp";
			flake = false;
		};
		cmp-path = {
			url = "github:hrsh7th/cmp-path";
			flake = false;
		};
		cmp-nvim-lsp = {
			url = "github:hrsh7th/cmp-nvim-lsp";
			flake = false;
		};
		cmp-buffer = {
			url = "github:hrsh7th/cmp-buffer";
			flake = false;
		};
		cmp-cmdline = {
			url = "github:hrsh7th/cmp-cmdline";
			flake = false;
		};
		cmp_luasnip = {
			url = "github:saadparwaiz1/cmp_luasnip";
			flake = false;
		};

		# Snippets
		luasnip = {
			url = "github:L3MON4D3/LuaSnip";
			flake = false;
		};
		friendly-snippets = {
			url = "github:rafamadriz/friendly-snippets";
			flake = false;
		};

		# Syntax
		nvim-autopairs = {
			url = "github:windwp/nvim-autopairs";
			flake = false;
		};
		nvim-ts-autotag = {
			url = "github:windwp/nvim-ts-autotag";
			flake = false;
		};

		# Git
		gitsigns-nvim = {
			url = "github:lewis6991/gitsigns.nvim";
			flake = false;
		};

		# Indent lines
		indent-blankline-nvim = {
			url = "github:lukas-reineke/indent-blankline.nvim";
			flake = false;
		};

		# Notes
		mkdnflow = {
			url = "github:jakewvincent/mkdnflow.nvim";
			flake = false;
		};

		# Commenting
		comment-nvim = {
			url = "github:numToStr/Comment.nvim";
			flake = false;
		};
		nvim-ts-context-commentstring = {
			url = "github:JoosepAlviste/nvim-ts-context-commentstring";
			flake = false;
		};
		todo-comments-nvim = {
			url = "github:folke/todo-comments.nvim";
			flake = false;
		};

		# Colors
		nvim-colorizer-lua = {
			url = "github:NvChad/nvim-colorizer.lua";
			flake = false;
		};

		# Motion
		leap-nvim = {
			url = "github:ggandor/leap.nvim";
			flake = false;
		};
		leap-spooky-nvim = {
			url = "github:ggandor/leap-spooky.nvim";
			flake = false;
		};

		##### Treesitter Lanugages
		tree-sitter-bash = {
			url = "github:tree-sitter/tree-sitter-bash";
			flake = false;
		};
		tree-sitter-c = {
			url = "github:tree-sitter/tree-sitter-c";
			flake = false;
		};
		tree-sitter-cpp = {
			url = "github:tree-sitter/tree-sitter-cpp";
			flake = false;
		};
		tree-sitter-css = {
			url = "github:tree-sitter/tree-sitter-css";
			flake = false;
		};
		tree-sitter-dockerfile = {
			url = "github:camdencheek/tree-sitter-dockerfile";
			flake = false;
		};
		tree-sitter-gitignore = {
			url = "github:shunsambongi/tree-sitter-gitignore";
			flake = false;
		};
		tree-sitter-graphql = {
			url = "github:bkegley/tree-sitter-graphql";
			flake = false;
		};
		tree-sitter-haskell = {
			url = "github:tree-sitter/tree-sitter-haskell";
			flake = false;
		};
		tree-sitter-html = {
			url = "github:tree-sitter/tree-sitter-html";
			flake = false;
		};
		tree-sitter-javascript = {
			url = "github:tree-sitter/tree-sitter-javascript";
			flake = false;
		};
		tree-sitter-json = {
			url = "github:tree-sitter/tree-sitter-json";
			flake = false;
		};
		tree-sitter-latex = {
			url = "github:latex-lsp/tree-sitter-latex";
			flake = false;
		};
		tree-sitter-lua = {
			url = "github:MunifTanjim/tree-sitter-lua";
			flake = false;
		};
		tree-sitter-make = {
			url = "github:alemuller/tree-sitter-make";
			flake = false;
		};
		tree-sitter-markdown = {
			url = "github:Mdeiml/tree-sitter-markdown";
			flake = false;
		};
		tree-sitter-markdown-inline.follows = "tree-sitter-markdown";
		tree-sitter-nix = {
			url = "github:cstrahan/tree-sitter-nix";
			flake = false;
		};
		tree-sitter-norg = {
			url = "github:nvim-neorg/tree-sitter-norg";
			flake = false;
		};
		tree-sitter-python = {
			url = "github:tree-sitter/tree-sitter-python";
			flake = false;
		};
		tree-sitter-regex = {
			url = "github:tree-sitter/tree-sitter-regex";
			flake = false;
		};
		tree-sitter-rust = {
			url = "github:tree-sitter/tree-sitter-rust";
			flake = false;
		};
		tree-sitter-scss = {
			url = "github:serenadeai/tree-sitter-scss";
			flake = false;
		};
		tree-sitter-svelte = {
			url = "github:Himujjal/tree-sitter-svelte";
			flake = false;
		};
		tree-sitter-toml = {
			url = "github:ikatyang/tree-sitter-toml";
			flake = false;
		};
		tree-sitter-typescript = {
			url = "github:tree-sitter/tree-sitter-typescript";
			flake = false;
		};
		tree-sitter-vim = {
			url = "github:vigoux/tree-sitter-viml";
			flake = false;
		};
		tree-sitter-yuck = {
			url = "github:Philipp-M/tree-sitter-yuck";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, neovim-nightly, ... } @ inputs:
		let
			system = "x86_64-linux";
			plugins = [
				"plenary-nvim"
				"nui-nvim"
				"popup-nvim"
				"nvim-notify"
				"nvim-web-devicons"
				"tokyonight-nvim"
				"heirline-nvim"
				"alpha-nvim"
				"dashboard-nvim"
				"veil-nvim"
				"noice-nvim"
				"neo-tree-nvim"
				"telescope-nvim"
				"toggleterm-nvim"
				"nvim-lspconfig"
				"SchemaStore-nvim"
				"nvim-treesitter"
				"nvim-cmp"
				"cmp-path"
				"cmp-nvim-lsp"
				"cmp-buffer"
				"cmp-cmdline"
				"cmp_luasnip"
				"luasnip"
				"friendly-snippets"
				"nvim-autopairs"
				"nvim-ts-autotag"
				"gitsigns-nvim"
				"indent-blankline-nvim"
				"mkdnflow"
				# "telekasten-nvim"
				"comment-nvim"
				"nvim-ts-context-commentstring"
				"todo-comments-nvim"
				"nvim-colorizer-lua"
				"leap-nvim"
				"leap-spooky-nvim"
			];
			grammars = [
				"tree-sitter-bash"
				"tree-sitter-c"
				"tree-sitter-cpp"
				"tree-sitter-css"
				"tree-sitter-dockerfile"
				"tree-sitter-gitignore"
				"tree-sitter-graphql"
				"tree-sitter-haskell"
				"tree-sitter-html"
				"tree-sitter-javascript"
				"tree-sitter-json"
				"tree-sitter-latex"
				"tree-sitter-lua"
				"tree-sitter-make"
				"tree-sitter-markdown"
				"tree-sitter-markdown-inline"
				"tree-sitter-nix"
				"tree-sitter-norg"
				"tree-sitter-python"
				"tree-sitter-regex"
				"tree-sitter-rust"
				"tree-sitter-scss"
				"tree-sitter-svelte"
				"tree-sitter-toml"
				"tree-sitter-typescript"
				"tree-sitter-vim"
				"tree-sitter-yuck"
			];
			pluginOverlay = lib.buildPluginOverlay;
			pkgs = import nixpkgs {
				inherit system neovim-nightly;
				overlays = [
					pluginOverlay
					(final: prev: {
						# neovim-unwrapped = neovim-nightly.packages.${prev.system}.neovim.overrideAttrs (old: {
						# 	patches = builtins.filter (p:
						# 		(if builtins.typeOf p == "set" then baseNameOf p.name else baseNameOf) != "neovim-build-make-generated-source-files-reproducible.patch")
						# 	old.patches;
						# });
						# neovim-unwrapped = neovim-nightly.packages.${prev.system}.neovim;
						# vimPlugins = prev.vimPlugins.override {
						# 	plugins.nvim-treesitter.src = inputs.nvim-treesitter;
						# };
					})
				];
			};
			lib = import ./lib { inherit pkgs inputs plugins grammars; };
			inherit (lib) neovimBuilder;
		in rec {
			apps.${system} = rec {
				nvim = {
					type = "app";
					program = "${packages.${system}.default}/bin/nvim";
				};
				default = nvim;
			};
			
			devShells.${system} = {
				default = pkgs.mkShell {
					buildInputs = with pkgs; [
						lua-language-server
						rnix-lsp
					] ++ [
						neovimBuilder
					];
				};
			};

			overlays.default = final: prev: rec {
				inherit neovimBuilder;
				inherit (packages.${system}) nvcode;
				inherit (pkgs) neovimPlugins;
			};

			packages.${system} = rec {
				default = nvcode;
				nvcode = neovimBuilder;
			};
		};
}
