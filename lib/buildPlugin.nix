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

	# overrides = pkgs.callPackage ./override.nix {
	# 	inherit (pkgs inputs grammars);
	# };

	overrides = final: prev: {
		nvim-treesitter = prev.nvim-treesitter.overrideAttrs (old:
			# pkgs.callPackage ./treesitterOverrides.nix { inherit pkgs inputs grammars; } final prev
			pkgs.callPackage ./treesitterOverrides.nix {} final prev
		);
	};

	neovimPluginsBase = self: builtins.listToAttrs (map (name: { inherit name; value = buildPlug name; }) plugins);
in {
	neovimPlugins = pkgs.lib.makeExtensible (pkgs.lib.extends overrides neovimPluginsBase);
}
