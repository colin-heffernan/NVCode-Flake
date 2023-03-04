{ pkgs, inputs, grammars, ... }: final: prev:
let
	generatedGrammars = let
		inherit grammars;
		buildGrammar = lang: pkgs.tree-sitter.buildGrammar {
			language = pkgs.lib.removePrefix "tree-sitter-" lang;
			version = "master";
			src = if (lang == "tree-sitter-markdown-inline") then (builtins.getAttr (pkgs.lib.removeSuffix "-inline" lang) inputs) else (builtins.getAttr lang inputs);
			location = if (lang == "tree-sitter-markdown") then "tree-sitter-markdown" else if (lang == "tree-sitter-markdown-inline") then "tree-sitter-markdown-inline" else "";
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

	allGrammars = pkgs.lib.attrValues generatedDerivations;

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

	withAllGrammars = withPlugins (_: allGrammars);
in
{
	postPatch = ''
		rm -r parser
	'';
	passthru = {
		inherit builtGrammars allGrammars withPlugins withAllGrammars;
	};
}
