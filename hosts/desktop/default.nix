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
    hyprland.enable = true;

    dms = {
      enable = true;

      greeter = {
        configUser = "robin";
      };
    };

    users.robin = {
      homeManager = {
        enable = true;
        configPath = ../../home/users/robin;
      };

      sudo = {
        enable = true;
        withoutPassword = true;
      };
    };
  };

  boot = {
    plymouth.enable = true;
  };

  networking = {
    # Use NetworkManager on desktop
    networkmanager.enable = true;

    # Use a firewall
    firewall.enable = true;
    nftables.enable = true;
  };

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
