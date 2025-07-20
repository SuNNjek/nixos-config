{ lib, pkgs, username, ... }: {
	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;

		extraSpecialArgs = { inherit username; };
	};
}