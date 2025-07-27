{ pkgs, inputs, username, ... }: {
	imports = [
		../shared.nix
		./hardware-configuration.nix

		inputs.disko.nixosModules.disko
		../btrfs-layout.nix

		inputs.home-manager.nixosModules.home-manager
		../../modules/home-manager.nix

		../../modules/kde.nix
		../../modules/flatpak.nix
		../../modules/zsh.nix
	];

	# TODO: Add more stuff here
	networking.hostName = "nixosVm";

	users.users.${username} = {
	  isNormalUser = true;
	  extraGroups = [ "wheel" ];
	};

	home-manager.users.${username} = import ../../home/users/${username};
}
