{ lib, pkgs, inputs, username, rootDev ? "/dev/sda", ... }: {
	imports = [
		../shared.nix
		./hardware-configuration.nix

		inputs.disko.nixosModules.disko
		../disko-btrfs.nix

		inputs.home-manager.nixosModules.home-manager

		../../modules/home-manager.nix
		../../modules/zsh.nix
	];

    boot.loader.grub = {
        efiSupport = lib.mkForce false;
        device = lib.mkForce rootDev;
    };

	boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

	networking.hostName = "school-laptop";
    networking.networkmanager.enable = true;

	users.users.${username} = {
	  isNormalUser = true;
	  extraGroups = [ "wheel" ];
	};

	home-manager.users.${username} = import ../../home/users/${username};
}
