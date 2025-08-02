{ pkgs, ... }: {
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

	services.hyprpaper = {
		enable = true;

		settings = {
			ipc = "on";
		};
	};

	home = {
		packages = with pkgs; [
			bibata-cursors
		];

		pointerCursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Ice";
			size = 24;

			hyprcursor = {
				enable = true;
				size = 24;
			};
		};
	};

	xdg.portal = {
		enable = true;
		xdgOpenUsePortal = true;

		# xdg-desktop-portal-hyprland doesn't implement a file picker.
		# According to the docs, you should install the GTK one as well.
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

	programs.zsh.initContent = ''
		if uwsm check may-start && uwsm select; then
			exec uwsm start default
		fi
	'';
}
