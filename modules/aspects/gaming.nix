{ lib, den, ... }:
let
  addUserToGamemodeGroup = { host, user, ... }: {
    nixos.users.users.${user.userName}.extraGroups = [
      "gamemode"
    ];
  };
in
{
  den.aspects.gaming = {
    includes = [
      (den.batteries.unfree [
        "steam"
        "steam-unwrapped"
      ])

      addUserToGamemodeGroup
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
          exec = "steam -nochatui -nofriendsui -silent";
        };
      in
      {
        home = {
          packages = with pkgs; [
            protonup-rs
            prismlauncher
            ubisoft-connect
            uwu-launch
          ];

          sessionVariables = {
            PROTON_ENABLE_WAYLAND = 1;
          };
        };

        programs.mangohud = {
          enable = true;
          enableSessionWide = true;

          settings = {
            no_display = true;
            wine = true;
            display_server = true;
          };
        };

        xdg.autostart.entries = [
          "${steamAutostart}/share/applications/steam.desktop"
        ];
      };
  };
}
