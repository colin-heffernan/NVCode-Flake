{ pkgs, grammars }: self: super:
let
	generatedGrammars = let
		buildGrammar = lang: pkgs.tree-sitter.buildGrammar {
			language = lang;
			version = "master";
			src = builtins.getAttr ("tree-sitter-" ++ lang) inputs;
		};
	in
		builtins.listToAttrs (map (name: { inherit name; value = buildGrammar name; }) grammars);

	generatedDerivations = lib.filterAttrs (_: lib.isDerivation) generatedGrammars;

	builtGrammars = generatedGrammars // lib.concatMapAttrs (k: v: 
	let
		replaced = lib.replaceStrings [ "_" ] [ "-" ] k;
	in {
		"tree-sitter-${k}" = v;
	} // lib.optionalAttrs (k != replaced) {
		${replaced} = v;
		"tree-sitter-${replaced}" = v;
	}) generatedDerivations;

	withPlugins =
		f: self.nvim-treesitter.overrideAttrs (_: {
			passthru.dependencies = map
				(grammar: let
					name = lib.pipe grammar [
						lib.getName

						# added in buildGrammar
						(lib.removeSuffix "-grammar")

						# grammars from tree-sitter.builtGrammars
						(lib.removePrefix "tree-sitter-")
						(lib.replaceStrings [ "-" ] [ "_" ])
					];
				in
					runCommand "nvim-treesitter-${name}-grammar" { } ''
	  					mkdir -p $out/parser
	    					ln -s ${grammar}/parser $out/parser/${name}.so
					''
				)
				(f (tree-sitter.builtGrammars // builtGrammars));
		});
in
{
	postPatch = ''
		rm -r parser
	'';
}
