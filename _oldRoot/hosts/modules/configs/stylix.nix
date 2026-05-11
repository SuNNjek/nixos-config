{
  inputs,
  pkgs,
  config,
  ...
}:
let
  cfg = config.sunner.stylix;
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = cfg.enable;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/material.yaml";
    polarity = "dark";

    # https://unsplash.com/photos/seashore-DA_tplYgTow
    image = ./assets/wallpaper.jpg;

    targets = {
      grub.useWallpaper = true;
      plymouth.logoAnimated = false;
    };

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

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
