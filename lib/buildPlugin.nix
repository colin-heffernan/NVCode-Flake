{ pkgs, inputs, plugins, ... }: final: prev: let
	inherit (prev.vimUtils) buildVimPluginFrom2Nix;

	treesitterGrammars = prev.tree-sitter.withPlugins (grammars: with grammars; [
		tree-sitter-bash
		tree-sitter-c
		tree-sitter-cpp
		tree-sitter-css
		tree-sitter-dockerfile
		tree-sitter-gdscript
		# tree-sitter-gitignore
		tree-sitter-graphql
		tree-sitter-haskell
		tree-sitter-html
		tree-sitter-javascript
		tree-sitter-json
		tree-sitter-latex
		tree-sitter-lua
		tree-sitter-markdown
		tree-sitter-nix
		tree-sitter-norg
		tree-sitter-python
		tree-sitter-regex
		tree-sitter-rust
		tree-sitter-scss
		tree-sitter-svelte
		tree-sitter-toml
		tree-sitter-typescript
		tree-sitter-vim
		# tree-sitter-yuck
	]);

	buildPlug = name: buildVimPluginFrom2Nix {
		pname = name;
		version = "master";
		src = builtins.getAttr name inputs;
		# passthru.dependencies = map
		# 	(grammar:
		# 		let
		# 			name = lib.pipe grammar [
		# 				lib.getName
		# 				(lib.removeSuffix "-grammar")
		# 				(lib.removePrefix "tree-sitter-")
		# 				(lib.replaceStrings [ "-" ] [ "_" ])
		# 			];
		# 		in
		# 			runCommand "nvim-treesitter-${name}-grammar" {} ''
		# 				mkdir -p $out/parser
		# 				ln -s ${grammar}/parser $out/parser/${name}.so
		# 			''
		# 		)
		# 		(f (free-sitter.builtGrammars // builtGrammars));
		postPatch = if (name == "nvim-treesitter") then ''
			rm -r parser
			ln -s ${treesitterGrammars} parser
		''
		else "";
	};
in {
	neovimPlugins = builtins.listToAttrs (map (name: { inherit name; value = buildPlug name; }) plugins);
}
