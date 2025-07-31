{ inputs, username, ... }: {
	imports = [
		../shared.nix
		./hardware-configuration.nix

		../../modules/disk-layouts

		inputs.home-manager.nixosModules.home-manager
		../../modules/home-manager.nix

		../../modules/hyprland.nix
		../../modules/pipewire.nix
		../../modules/home-manager.nix
		../../modules/flatpak.nix
		../../modules/zsh.nix
		../../modules/nh.nix
	];

	diskLayout = {
		btrfs = {
			enable = true;
			device = "/dev/sda";
		};

		tmp.enable = true;
	};

	# TODO: Add more stuff here
	networking.hostName = "nixosVm";

	users.users.${username} = {
	  isNormalUser = true;
	  extraGroups = [ "wheel" ];
	};

	nix.settings.trusted-users = [ username ];

	home-manager.users.${username} = import ../../home/users/${username};

	programs.nh.flake = "/home/${username}/git/nixos-config";
}
