{
  imports = [
    ../.
    ./hardware-configuration.nix
  ];

  sunner = {
    diskLayout = {
      btrfs = {
        enable = true;
        device = "/dev/nvme0n1";
      };
    };

    useCases = {
      development.enable = true;
      imageEditing.enable = true;
      audioEditing.enable = true;
    };
  };

  services = {
    power-profiles-daemon.enable = true;
  };

  networking = {
    hostName = "robin-thinkpad";
  };
}
