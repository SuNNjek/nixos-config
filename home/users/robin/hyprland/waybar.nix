{ lib, pkgs, ... }:
let 
	inherit (lib) mkAfter;
in {
	stylix.targets.waybar = {
		font = "sansSerif";

		addCss = false;
	};

	home.packages = with pkgs; [
		font-awesome
	];

	programs.waybar = {
		enable = true;
		systemd.enable = true;

		style = mkAfter (builtins.readFile ./waybar.css);

		settings = {
			mainBar = {
				layer = "top";
				position = "bottom";
				height = 40;

				modules-left = [
					"custom/launcher"
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

				"custom/launcher" = {
					format = "  <span font_family=\"Font Awesome 6 Free\"></span>  ";
					tooltip = false;
					on-click = "walker";
				};

				battery = {
					format = "<span font_family=\"Font Awesome 6 Free\">{icon}</span>  {capacity}%";
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
					format = "<span font_family=\"Font Awesome 6 Free\">{icon}</span>  {volume}%";
					format-icons = ["" "" ""];
				};

				cpu = {
					format = "<span font_family=\"Font Awesome 6 Free\"></span>  {usage}%";
				};

				memory = {
					format = "<span font_family=\"Font Awesome 6 Free\"></span>  {percentage}%  ({swapPercentage}%)";
				};

				tray = {
					icon-size = 21;
					spacing = 10;
				};

				"hyprland/window" = {
					separate-outputs = true;
					icon = true;
					icon-size = 20;
				};
			};
		};
	};
}
