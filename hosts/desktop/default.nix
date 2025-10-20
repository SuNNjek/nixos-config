{ config, ... }: {
  imports = [
    ../.

    ./modules/pipewire.nix
    ./modules/flatpak.nix
    ./modules/stylix.nix
  ];

  sunner = {
    zram.enable = true;

    homeManager = {
      enable = true;

      users = {
        robin = {
          configPath = ../../home/users/robin;

          sudo = {
            enable = true;
            withoutPassword = true;
          };
        };
      };
    };
  };

  # Use NetworkManager on desktop
  networking.networkmanager.enable = true;

  # Set the flake location for nh for rebuilding the system.
  # ofc you gotta clone it to that location yourself, this can't be done here ^^
  programs.nh.flake = "/home/robin/git/nixos-config";

  services = {
    # Set X server keyboard layout
    xserver = {
      xkb.layout = "de";
    };

    accounts-daemon.enable = true;
    upower.enable = true;

    blueman.enable = config.hardware.bluetooth.enable;
  };
}
