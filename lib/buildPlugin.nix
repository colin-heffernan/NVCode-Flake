{ pkgs, inputs, plugins, ... }: final: prev: let
	inherit (prev.neovimUtils) buildNeovimPluginFrom2Nix;

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

	buildPlug = name: buildNeovimPluginFrom2Nix {
		pname = name;
		version = "master";
		src = builtins.getAttr name inputs;
		# postPatch = if (name == "nvim-treesitter") then ''
		# 	rm -r parser
		# ''
		# else "";
	};
in {
	neovimPlugins = builtins.listToAttrs (map (name: { inherit name; value = buildPlug name; }) plugins);
}
