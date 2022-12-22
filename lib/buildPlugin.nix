{ pkgs, inputs, plugins, ... }: final: prev: let
	inherit (prev.vimUtils) buildVimPluginFrom2Nix;

	treesitterGrammars = prev.tree-sitter.withPlugins (plugins: with plugins; [
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
	]);

	buildPlug = name: buildVimPluginFrom2Nix {
		pname = name;
		version = "master";
		src = builtins.getAttr name inputs;
		postPatch = if (name == "nvim-treesitter") then ''
			rm -r parser
			ln -s ${treesitterGrammars} parser
		''
		else "";
	};
in {
	neovimPlugins = builtins.listToAttrs (map (name: { inherit name; value = buildPlug name; }) plugins);
}
