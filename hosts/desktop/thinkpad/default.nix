{
  imports = [
    ../.
    ./hardware-configuration.nix
  ];

  sunner = {
    boot.limine.enable = true;

    diskLayout = {
      btrfs = {
        enable = true;
        device = "/dev/nvme0n1";
      };

      tmp.enable = true;
    };
  };

  services = {
    power-profiles-daemon.enable = true;
  };

  networking = {
    hostName = "robin-thinkpad";
  };
}
