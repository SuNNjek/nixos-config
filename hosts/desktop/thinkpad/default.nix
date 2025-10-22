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
  };

  services = {
    power-profiles-daemon.enable = true;
  };

  networking = {
    hostName = "robin-thinkpad";
  };
}
