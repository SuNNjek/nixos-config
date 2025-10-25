{ lib, osConfig, pkgs, ... }: let 
  cfg = osConfig.sunner.useCases.gaming;
in lib.mkIf cfg.enable {
  programs.mangohud.enable = true;

  xdg = {
    autostart = {
      entries = with pkgs; [
        "${steam}/share/applications/steam.desktop"
      ];

      flatpaks = {
        "com.valvesoftware.Steam" = {
          enable = true;
          args = [ "-silent" ];
        };
      };
    };
  };
}
