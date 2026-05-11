{
  imports = [
    ../.
    ./hardware-configuration.nix
  ];

  sunner = {
    diskLayout = {
      btrfs = {
        enable = true;
        device = "/dev/sda";
      };
    };
  };

  networking.hostName = "nixos-vm";
}
