{ lib, pkgs, ... }: {
	imports = [
	  ../shared.nix

		./hyprland

	  ../../modules/autostart.nix
	  ../../modules/git.nix
	  ../../modules/firefox.nix
	  ../../modules/vscode.nix
	  ../../modules/zsh.nix
	];

	home = {
		packages = with pkgs; [
			fastfetch
			krabby

			nemo-with-extensions
			mpc-qt
			image-roll
			gimp3

			nixd
		];

		stateVersion = "25.05";

		sessionVariables = {
			NIXOS_OZONE_WL = "1";
		};
	};

	stylix = {
    enable = true;

    targets = {
      # Doesn't work properly yet
      gtk.flatpakSupport.enable = false;
    };
  };

	gtk = {
		enable = true;

		iconTheme = {
			package = pkgs.fluent-icon-theme;
			name = "Fluent-dark";
		};
	};

	xdg = {
		systemDirs.data = [
			"/home/robin/.local/share/flatpak/exports/share"
		];

		userDirs = {
			enable = true;
			createDirectories = true;
		};

    autostart.flatpaks = {
      steam = {
        id = "com.valvesoftware.Steam";
        args = "-silent";
      };
    };
	};

	programs = {
		vesktop.enable = true;

		git = {
			userName = "Sunner";
			userEmail = "sunnerlp@gmail.com";

      signing = {
        signByDefault = true;
        key = "068C46171236B7AD"; # Needs to be imported
      };
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

		gpg.enable = true;
	};

	services = {
		network-manager-applet.enable = true;

		gpg-agent = {
			enable = true;
			pinentry.package = pkgs.pinentry-qt;
		};

    blueman-applet.enable = true;
	};
}
