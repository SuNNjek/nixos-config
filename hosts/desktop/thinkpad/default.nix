{
	imports = [
		../.
		./hardware-configuration.nix

		../../modules/zram.nix

		../modules/hyprland.nix
	];

	diskLayout = {
		btrfs = {
			enable = true;
			device = "/dev/nvme0n1";
		};

		tmp.enable = true;
	};

	networking = {
		hostName = "robin-thinkpad";
	};
}
