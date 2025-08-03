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

	services.udisks2.enable = true;

	environment.systemPackages = with pkgs; [
		kitty

		waybar
		wev
	];
}
