{ pkgs, ... }: {
	programs = {
		hyprland = {
			enable = true;
			withUWSM = true;
		};

		regreet = {
			enable = true;
		};
	};

	services = {
		# For udiskie (auto-mounting drives)
		udisks2.enable = true;
		# For gammastep (red filter at night)
		geoclue2.enable = true;
	};

	environment.systemPackages = with pkgs; [
		kitty

		waybar
		wev
	];
}
