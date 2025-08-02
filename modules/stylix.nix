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
        name = "Roboto Regular";
      };

      serif = {
        package = pkgs.roboto-slab;
        name = "Roboto Slab Regular";
      };

      monospace = {
        package = pkgs.nerd-fonts.roboto-mono;
        name = "Roboto Mono NF";
      };
    };
	};
}