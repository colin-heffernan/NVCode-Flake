{ pkgs, inputs, plugins, ... }: final: prev: let
	inherit (prev.vimUtils) buildVimPluginFrom2Nix;

	treesitterGrammars = prev.vimPlugins.nvim-treesitter.withPlugins (grammars: with grammars; [
		bash
		c
		cpp
		css
		dockerfile
		gdscript
		# gitignore
		graphql
		haskell
		html
		javascript
		json
		latex
		lua
		markdown
		nix
		norg
		python
		regex
		rust
		scss
		svelte
		toml
		typescript
		vim
		# yuck
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
			ln -s ${treesitterGrammars/parser} parser
		''
		else "";
	};
in {
	neovimPlugins = builtins.listToAttrs (map (name: { inherit name; value = buildPlug name; }) plugins);
}
