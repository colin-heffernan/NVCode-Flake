{ pkgs }: final: prev: {
	nvim-treesitter = prev.nvim-treesitter.overrideAttrs (old:
		pkgs.callPackage ./treesitterOverrides.nix {} final prev
	);
}
