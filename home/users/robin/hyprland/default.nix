{ pkgs, ... }: {
	imports = [
		./binds.nix
		./rules.nix

		./waybar.nix
		./walker.nix
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
	};

	services.hyprpaper = {
		enable = true;

		settings = {
			ipc = "on";
		};
	};

	programs.zsh.initContent = ''
		if uwsm check may-start && uwsm select; then
			exec uwsm start default
		fi
	'';
}
