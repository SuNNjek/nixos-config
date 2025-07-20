{ lib, pkgs, username, ... }: {
	home = {
		inherit username;
		homeDirectory = "/home/${username}";
	};

	programs = {
		home-manager.enable = true;
	};
}
