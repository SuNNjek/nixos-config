{ lib, pkgs, ... }: {
	imports = [
		./binds.nix
		./rules.nix

		../walker
		./hypotd.nix
		./hyprlock.nix
		./waybar.nix
		./mako.nix
		./wlogout.nix
	];

	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"$terminal" = "kitty";

			general = {
				gaps_out = 8;
				gaps_in = 4;
			};

			input = {
				kb_layout = "de";
				# Focus window when clicking on it, not when hovering over it
				follow_mouse = 2;

				touchpad = {
					natural_scroll = true;
				};
			};

			decoration = {
				rounding = 8;

				blur = {
					passes = 2;
				};
			};

			monitor = [
				"desc:Dell Inc. DELL U2724DE 6QZ59P3,2560x1440@120,0x0,1"
				"desc:Dell Inc. DELL P2225H DNWN504,1920x1080@100,2560x0,1,transform,3"
				",highres,auto,1"
			];

			misc = {
				# Begone, anime girl
				disable_hyprland_logo = true;
			};
		};

		plugins = with pkgs; [
			csd-titlebar-move
		];
	};

	stylix.targets.hyprpaper.enable = lib.mkForce false;
	services = {
		hyprpaper = {
			enable = true;

			settings = {
				ipc = "on";
			};
		};

		hypridle = {
			enable = true;

			settings = {
				general = {
					lock_cmd = "pidof hyprlock || hyprlock";
					before_sleep_cmd = "loginctl lock-session";
					after_sleep_cmd = "hyprctl dispatch dpms on";
				};
			
				listener = [
					{
						timeout = 10 * 60;
						on-timeout = "loginctl lock-session";
					}
					{
						timeout = 15 * 60;
						on-timeout = "hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}
					{
						timeout = 30;
						on-timeout = "pidof hyprlock && hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}
				];
			};
		};

		hyprpolkitagent.enable = true;

		# Update this when hyprsunset 0.3 hits Nix stable
		gammastep = {
			enable = true;
			provider = "geoclue2";
		};

		udiskie.enable = true;
	};

	xdg.portal = {
		enable = true;
		xdgOpenUsePortal = true;

		# xdg-desktop-portal-hyprland doesn't implement a file picker.
		# According to the docs, you should install the GTK one as well.
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};
}
