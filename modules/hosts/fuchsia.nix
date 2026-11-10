{ inputs, den, ... }:
{
  #
  # "A historic village that has become new."
  #
  # Old PC that has become "new" in a smaller case.
  #

  den.hosts.x86_64-linux.fuchsia = {
    rootDrive = "/dev/nvme1n1";
    users.robin = { };
  };

  den.aspects.fuchsia = {
    includes = with den.aspects; [
      disko
      disko._.btrfs-root

      limine
      plymouth
      zram
      bluetooth
      nvidia

      locale._.de
      desktop
      niri
      niri._.dux
      dux

      matugen._.openrgb

      development
      gaming

      image-editing
    ];

    nixos = { ... }: {
      imports = with inputs.nixos-hardware.nixosModules; [
        common-cpu-intel
        common-pc
        common-pc-ssd
      ];

      boot = {
        extraModulePackages = [ ];
        kernelModules = [
          "kvm-intel"
        ];

        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "nvme"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ ];
        };
      };

      hardware = {
        bluetooth.enable = true;
      };

      services.hardware.openrgb.enable = true;
    };
  };
}
