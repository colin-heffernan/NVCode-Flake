{ pkgs, inputs, plugins, grammars, ... }: final: prev: let
	inherit (prev.vimUtils) buildVimPluginFrom2Nix;

	# treesitterGrammars = prev.vimPlugins.nvim-treesitter.withPlugins (grammars: with grammars; [
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
	# ]);

	buildPlug = name: buildVimPluginFrom2Nix {
		pname = name;
		version = "master";
		src = builtins.getAttr name inputs;
		# postPatch = if (name == "nvim-treesitter") then ''
		# 	rm -r parser
		# ''
		# else "";
	};

	overrides = {
		nvim-treesitter = prev.nvim-treesitter.overrideAttrs (old:
			pkgs.callPackage ./treesitterOverrides.nix {} final prev
		);
	};
in {
	neovimPlugins = builtins.listToAttrs (map pkgs.lib.makeExtensible (extends overrides (name: { inherit name; value = buildPlug name; })) plugins);
}
