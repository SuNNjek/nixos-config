{ lib, osConfig, pkgs, ... }: let 
  cfg = osConfig.sunner.useCases.gaming;
in lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    prismlauncher
  ];

  programs.mangohud.enable = true;

  services.flatpak.packages = [
    "com.usebottles.bottles"
  ];

  xdg = {
    autostart = {
      entries = with pkgs; [
        "${steam}/share/applications/steam.desktop"
      ];
    };
  };
}
