{ lib, den, ... }:
{
  den.aspects.gaming = {
    includes = [
      (den.batteries.unfree [ "steam" "steam-unwrapped" ])
    ];

    nixos =
      { pkgs, ... }:
      {
        programs = {
          gamescope.enable = true;
          gamemode.enable = true;

          steam = {
            enable = true;
            protontricks.enable = true;

            extraCompatPackages = with pkgs; [
              proton-ge-bin
            ];

            # Open ports for some functionality in the firewall
            remotePlay.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
          };
        };

        services.udev.packages = with pkgs; [
          steam-devices-udev-rules
        ];
      };

    homeManager =
      { pkgs, ... }:
      let
        steamAutostart = pkgs.makeDesktopItem {
          name = "steam";
          desktopName = "Steam";
          exec = "${lib.getExe pkgs.steam} -nochatui -nofriendsui -silent";
        };
      in
      {
        home.packages = with pkgs; [
          protonup-rs
          prismlauncher
          ubisoft-connect
          uwu-launch
        ];

        programs.mangohud.enable = true;

        xdg.autostart.entries = [
          "${steamAutostart}/share/applications/steam.desktop"
        ];
      };
  };
}
