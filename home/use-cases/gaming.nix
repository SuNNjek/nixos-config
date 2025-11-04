{ lib, osConfig, pkgs, ... }: let 
  cfg = osConfig.sunner.useCases.gaming;

  steamAutostart = pkgs.makeDesktopItem {
    name = "steam";
    desktopName = "Steam";
    exec = "${lib.getExe pkgs.steam} -nochatui -nofriendsui -silent";
  };
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
      entries = [
        "${steamAutostart}/share/applications/steam.desktop"
      ];
    };
  };
}
