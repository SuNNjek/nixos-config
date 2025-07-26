{ lib, pkgs, username, inputs, ... }: {
	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;

		extraSpecialArgs = { inherit username inputs; };
	};
}
