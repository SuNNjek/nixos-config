{ inputs, pkgs, ... }: {
  imports = [
		inputs.stylix.nixosModules.stylix
  ];

	stylix = {
		enable = true;
		autoEnable = true;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/material.yaml";
		polarity = "dark";

    fonts = {
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };

      serif = {
        package = pkgs.roboto-slab;
        name = "Roboto Slab";
      };

      monospace = {
        package = pkgs.nerd-fonts.roboto-mono;
        name = "RobotoMono Nerd Font Mono";
      };
    };
	};
}