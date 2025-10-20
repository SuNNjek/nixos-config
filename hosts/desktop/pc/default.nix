{
  imports = [
    ../.
    ./hardware-configuration.nix
  ];

  sunner = {
    boot.limine = {
      enable = true;

      extraEntries = ''
        /Windows
          protocol: efi
          path: uuid(7006ed1b-b7fa-40ec-92af-fd0fae8ef4e2):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
    };

    diskLayout = {
      btrfs = {
        enable = true;
        device = "/dev/nvme1n1";
      };

      tmp = {
        enable = true;
        size = "8G";
      };
    };
  };

  services = {
    hardware.openrgb.enable = true;
  };

  networking = {
    hostName = "robin-pc";
  };

  boot = {
    plymouth.enable = true;
  };

  stylix.targets.plymouth.logoAnimated = false;
}
