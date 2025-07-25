{ lib, pkgs, ... }: {
	programs.zsh = {
		enable = true;

		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		plugins = [
			{
				name = "powerlevel10k";
				src = pkgs.zsh-powerlevel10k;
				file = "/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
			}
			{
				name = "powerlevel10k-config";
				src = lib.cleanSource ./p10k-config;
				file = "p10k.zsh";
			}
		];
	};

	home.packages = with pkgs; [
		meslo-lgs-nf
	];
}
