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

	environment.systemPackages = with pkgs; [
		kitty

		waybar
		wev
	];
}
