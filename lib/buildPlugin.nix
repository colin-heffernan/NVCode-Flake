{ pkgs, inputs, plugins, ... }: final: prev: let
	inherit (prev.vimUtils) buildVimPluginFrom2Nix;

	treesitterGrammars = prev.tree-sitter.withPlugins (plugins: with plugins; [
		tree-sitter-bash
		tree-sitter-c
		tree-sitter-cpp
		tree-sitter-css
		tree-sitter-haskell
		tree-sitter-html
		tree-sitter-javascript
		tree-sitter-json
		tree-sitter-latex
		tree-sitter-lua
		tree-sitter-markdown
		tree-sitter-markdown-inline
		tree-sitter-nix
		tree-sitter-norg
		tree-sitter-python
		tree-sitter-regex
		tree-sitter-rust
		tree-sitter-svelte
		tree-sitter-typescript
		tree-sitter-vim
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
