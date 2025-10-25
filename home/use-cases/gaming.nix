{ lib, osConfig, pkgs, ... }: let 
  cfg = osConfig.sunner.useCases.gaming;
in lib.mkIf cfg.enable (
  lib.mkMerge [
    {
      home.packages = with pkgs; [
        prismlauncher
      ];

      programs.mangohud.enable = true;

      xdg = {
        autostart = {
          entries = with pkgs; [
            "${steam}/share/applications/steam.desktop"
          ];
        };
      };
    }

    (lib.mkIf osConfig.sunner.flatpak.enable {
      xdg.autostart.flatpaks = {
        "com.valvesoftware.Steam" = {
          enable = true;
          args = [ "-silent" ];
        };
      };
    })
  ]
)
