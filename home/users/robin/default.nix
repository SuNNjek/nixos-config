{ lib, pkgs, ... }: {
	imports = [
	  ../shared.nix

		./hyprland

	  ../../modules/git.nix
	  ../../modules/firefox.nix
	  ../../modules/vscode.nix
	  ../../modules/zsh.nix
	];

	home = {
		packages = with pkgs; [
			neofetch
			krabby

			nautilus

			nixd
		];

		stateVersion = "25.05";

		sessionVariables = {
			NIXOS_OZONE_WL = "1";
		};
	};

	gtk = {
		enable = true;

		theme = {
			package = pkgs.fluent-gtk-theme;
			name = "Fluent-Dark";
		};

		iconTheme = {
			package = pkgs.fluent-icon-theme;
			name = "Fluent-dark";
		};
	};

	xdg = {
		systemDirs.data = [
			"/home/robin/.local/share/flatpak/exports/share"
		];
	};

	programs = {
		vesktop.enable = true;

		git = {
			userName = "Sunner";
			userEmail = "sunnerlp@gmail.com";
		};

		direnv = {
			enable = true;
			enableZshIntegration = true;

			nix-direnv.enable = true;
		};

		kitty = {
			shellIntegration.enableZshIntegration = true;
			font.name = "MesloLGS NF";
		};
	};

	services = {
		network-manager-applet.enable = true;
	};
}
