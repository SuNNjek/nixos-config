{
  imports = [
    ../.
    ./hardware-configuration.nix

    ../modules/regreet.nix
  ];

  sunner.diskLayout = {
    btrfs = {
      enable = true;
      device = "/dev/sda";
    };

    tmp.enable = true;
  };

  networking.hostName = "nixos-vm";
}
