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

	generatedDerivations = pkgs.lib.filterAttrs (_: pkgs.lib.isDerivation) generatedGrammars;

	builtGrammars = generatedGrammars // pkgs.lib.concatMapAttrs (k: v: 
	let
		replaced = pkgs.lib.replaceStrings [ "_" ] [ "-" ] k;
	in {
		"tree-sitter-${k}" = v;
	} // pkgs.lib.optionalAttrs (k != replaced) {
		${replaced} = v;
		"tree-sitter-${replaced}" = v;
	}) generatedDerivations;

	withPlugins =
		f: self.nvim-treesitter.overrideAttrs (_: {
			passthru.dependencies = map
				(grammar: let
					name = pkgs.lib.pipe grammar [
						pkgs.lib.getName

						# added in buildGrammar
						(pkgs.lib.removeSuffix "-grammar")

						# grammars from tree-sitter.builtGrammars
						(pkgs.lib.removePrefix "tree-sitter-")
						(pkgs.lib.replaceStrings [ "-" ] [ "_" ])
					];
				in
					runCommand "nvim-treesitter-${name}-grammar" { } ''
	  					mkdir -p $out/parser
	    					ln -s ${grammar}/parser $out/parser/${name}.so
					''
				)
				(f (pkgs.tree-sitter.builtGrammars // builtGrammars));
		});
in
{
	postPatch = ''
		rm -r parser
	'';
}
