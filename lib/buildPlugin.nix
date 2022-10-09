{ pkgs, inputs, plugins, ... }: final: prev: let
	inherit (prev.vimUtils) buildVimPluginFrom2Nix;

	treesitterGrammars = prev.tree-sitter.withPlugins (p: [
		p.tree-sitter-bash
		p.tree-sitter-c
		p.tree-sitter-cpp
		p.tree-sitter-css
		p.tree-sitter-haskell
		p.tree-sitter-html
		p.tree-sitter-javascript
		p.tree-sitter-json
		p.tree-sitter-latex
		p.tree-sitter-lua
		p.tree-sitter-markdown
		p.tree-sitter-markdown-inline
		p.tree-sitter-nix
		p.tree-sitter-norg
		p.tree-sitter-python
		p.tree-sitter-regex
		p.tree-sitter-rust
		p.tree-sitter-svelte
		p.tree-sitter-typescript
		p.tree-sitter-vim
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
