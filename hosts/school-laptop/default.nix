{ pkgs, inputs, username, ... }: {
	imports = [
		../shared.nix
		./hardware-configuration.nix

		inputs.disko.nixosModules.disko
		../disko-btrfs.nix

		inputs.home-manager.nixosModules.home-manager

		../../modules/home-manager.nix
		../../modules/zsh.nix
	];

	networking.hostName = "school-laptop";
    networking.networkmanager.enable = true;

	users.users.${username} = {
	  isNormalUser = true;
	  extraGroups = [ "wheel" ];
	};

	home-manager.users.${username} = import ../../home/users/${username};
}
