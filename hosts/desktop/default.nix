{ config, pkgs, ... }: {
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
    flatpak.enable = true;

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

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
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
    gvfs.enable = true;

    blueman.enable = config.hardware.bluetooth.enable;
  };

  environment = {
    systemPackages = with pkgs; [
      unzip
      p7zip
      file
    ];
  };
}
