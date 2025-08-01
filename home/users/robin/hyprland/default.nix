{ pkgs, inputs, ... }: {
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

			input = {
				kb_layout = "de";

				touchpad = {
					natural_scroll = true;
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
				background_color = "0x0094de";
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

	programs.zsh.initContent = ''
		if uwsm check may-start && uwsm select; then
			exec uwsm start default
		fi
	'';
}
