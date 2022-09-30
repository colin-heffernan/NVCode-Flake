{ pkgs }:
pkgs.stdenv.mkDerivation {
	pname = "neovim-configs";
	version = "1.0.0";
	src = "../configs/";
	installPhase = ''
		cp -r ../configs $out
	'';
}
