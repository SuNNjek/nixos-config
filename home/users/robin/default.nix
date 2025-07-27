{ lib, pkgs, ... }: {
	imports = [
	  ../shared.nix

	  ../../modules/klassy

	  ../../modules/git.nix
	  ../../modules/firefox.nix
	  ../../modules/vscode.nix
	  ../../modules/zsh.nix
	];

	home = {
		packages = with pkgs; [
			neofetch
			krabby
		];

		stateVersion = "25.05";
	};

	xdg = {
		systemDirs.data = [
			"/home/robin/.local/share/flatpak/exports/share"
		];
	};

	programs = {
		git = {
			userName = "Sunner";
			userEmail = "sunnerlp@gmail.com";
		};

		direnv = {
			enable = true;
			enableZshIntegration = true;

			nix-direnv.enable = true;
		};
	};
}
