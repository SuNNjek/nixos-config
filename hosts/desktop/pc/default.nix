{
  imports = [
    ../.
    ./hardware-configuration.nix
  ];

  sunner = {
    boot.limine.extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(7006ed1b-b7fa-40ec-92af-fd0fae8ef4e2):/EFI/Microsoft/Boot/bootmgfw.efi
    '';

    diskLayout = {
      btrfs = {
        enable = true;
        device = "/dev/nvme1n1";
      };

      tmp.size = "8G";
    };

    useCases = {
      development.enable = true;
      gaming.enable = true;
      imageEditing.enable = true;
      videoEditing.enable = true;
    };
  };

  services = {
    hardware.openrgb.enable = true;
  };

  networking = {
    hostName = "robin-pc";
  };
}
