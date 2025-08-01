{
	programs.waybar = {
		enable = true;
		systemd.enable = true;

		style = ./waybar.css;

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
					"wireplumber"
					"battery"
					"cpu"
					"memory"
					"clock"
				];

				battery = {
					format = "{icon} {capacity}%";
					format-icons = [
						"" # Icon: battery-full
						"" # Icon: battery-three-quarters
						"" # Icon: battery-half
						"" # Icon: battery-quarter
						"" # Icon: battery-empty
					];
				};

				wireplumber = {
					on-click = "pavucontrol";
					format = "{volume}% {icon}";
					format-icons = ["" "" ""];
				};

				cpu = {
					format = "  {usage}% ({load})";
				};

				memory = {
					format = "  {}%";
				};

				tray = {
					icon-size = 21;
					spacing = 10;
				};

				"hyprland/window" = {
					separate-outputs = true;
				};
			};
		};
	};
}
