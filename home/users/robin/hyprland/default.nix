{ pkgs, ... }: {
	imports = [
		./binds.nix
		./rules.nix

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
			};

			monitor = ",highres,auto,1";
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
