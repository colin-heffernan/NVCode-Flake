{ pkgs, inputs, grammars }: final: prev:
let
	generatedGrammars = let
		buildGrammar = lang: pkgs.tree-sitter.buildGrammar {
			language = lang;
			version = "master";
			src = builtins.getAttr ("tree-sitter-" ++ lang) inputs;
		};
	in
		self: builtins.listToAttrs (map (lang: { inherit lang; value = buildGrammar lang; }) grammars);

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
		f: final.nvim-treesitter.overrideAttrs (_: {
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
					pkgs.runCommand "nvim-treesitter-${name}-grammar" { } ''
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
