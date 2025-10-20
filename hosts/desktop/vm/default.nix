{
  imports = [
    ../.
    ./hardware-configuration.nix

    ../modules/regreet.nix
  ];

  sunner = {
    boot.limine.enable = true;

    diskLayout = {
      btrfs = {
        enable = true;
        device = "/dev/sda";
      };

      tmp.enable = true;
    };
  };

  networking.hostName = "nixos-vm";
}
