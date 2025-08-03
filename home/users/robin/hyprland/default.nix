{ lib, pkgs, ... }: {
	imports = [
		./binds.nix
		./rules.nix

		./hypotd.nix
		./waybar.nix
		./walker.nix
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
				"desc:Dell Inc. DELL U2724DE 6QZ59P3,highres,auto,1"
				"desc:Dell Inc. DELL P2225H DNWN504,highres,auto,1,transform,3"
				",highres,auto,1"
			];

			misc = {
				# Begone, anime girl
				disable_hyprland_logo = true;
				#background_color = "0x0094de";
			};
		};

		plugins = with pkgs; [
			(callPackage ./titlebar-move.nix {})
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

		hyprpolkitagent.enable = true;

		# Update this when hyprsunset 0.3 hits Nix stable
		hyprsunset = {
			enable = true;
			transitions = {
			  sunrise = {
				calendar = "*-*-* 06:00:00";
				requests = [
				  [ "temperature" "6500" ]
				  [ "gamma 100" ]
				];
			  };
			  sunset = {
				calendar = "*-*-* 19:00:00";
				requests = [
				  [ "temperature" "3500" ]
				];
			  };
			};	
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
