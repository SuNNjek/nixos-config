{
	inputs = {
		# This is pointing to release 25.05
		# If you prefer another release instead, you can set this to the latest number shown here: https://nixos.org/download
		# i.e. nixos-24.11
		# You can also use unstable for the unstable channel.
		# Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		disko = {
			url = "github:nix-community/disko/latest";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		walker = {
			url = "github:abenz1267/walker";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = inputs@{ self, nixpkgs, ... }: {
		# NOTE: 'nixos' is the default hostname
		nixosConfigurations = {
			nixosVm = let
				username = "robin";
			in
				nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs username; };
					modules = [
						./hosts/vm
					];
			};
		};
	};
}

