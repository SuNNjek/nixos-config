{
	programs.waybar = {
		enable = true;
		systemd.enable = true;

		settings = {
			mainBar = {
				layer = "top";
				position = "bottom";
				height = 40;

				modules-left = [
					"hyprland/workspaces"
					"hyprland/window"
				];

				modules-right = [
					"tray"
					"network"
					"pulseaudio"
					"cpu"
					"memory"
					"clock"
				];

				pulseaudio = {
					on-click = "pavucontrol";
				};
			};
		};
	};
}
