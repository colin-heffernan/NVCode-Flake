# NVCode

NVCode is my personal Neovim configuration. This is that configuration bundled with a custom wrapped version of Neovim Nightly in the form of a Nix Flake. This makes it easy to install and use on NixOS, my operating system of choice.


# Installation

## NixOS

Installing on NixOS is super easy. Just add NVCode to your Flake inputs, add the overlay to your Nixpkgs overlays, and install the package.
`flake.nix`
```nix
{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nvcode = {
			url = "github:colin-heffernan/NVCode";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = { self, nixpkgs, nvcode, ... } @ inputs:
		let
			system = "x84_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				overlays = [
					nvcode.overlays.default
				];
			};
		in {
			nixosConfigurations = {
				username = lib.nixosSystem {
					inherit system pkgs;
					modules = [
						./configuration.nix
					];
				};
			};
		};
}
```
`configuration.nix`
```nix
{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		nvcode
	];
}
```


## Non-NixOS

See [NVCode](https://github.com/colin-heffernan/NVCode).


# License

NVCode Flake is licensed under the MIT License.
