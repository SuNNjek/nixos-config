{ pkgs, inputs, username, ... }: {
	imports = [
		../shared.nix
		./hardware-configuration.nix

		inputs.disko.nixosModules.disko
		./disk-layout.nix

		inputs.home-manager.nixosModules.home-manager

		../../modules/hyprland.nix
		../../modules/pipewire.nix
		../../modules/home-manager.nix
		../../modules/zsh.nix
	];

	# TODO: Add more stuff here
	networking.hostName = "nixosVm";

	users.users.${username} = {
	  isNormalUser = true;
	  extraGroups = [ "wheel" ];
	};

	nix.settings.trusted-users = [ username ];

	home-manager.users.${username} = import ../../home/users/${username};
}
