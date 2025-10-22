{ config, ... }: {
  imports = [
    ../.
  ];

  sunner = {
    diskLayout.tmp.enable = true;

    boot.limine.enable = true;
    
    stylix.enable = true;
    
    zram.enable = true;
    pipewire.enable = true;
    flatpak.enable = true;
    hyprland.enable = true;

    dms = {
      enable = true;

      greeter = {
        configUser = "robin";
      };
    };

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

  boot = {
    plymouth.enable = true;
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
