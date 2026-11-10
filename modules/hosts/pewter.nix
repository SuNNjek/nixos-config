{
  inputs,
  den,
  ...
}:
{
  #
  # "A quiet city nestled between rugged mountains and rocks."
  #
  # My Thinkpad, nestled between PC host configs.
  #

  den.hosts.x86_64-linux.pewter = {
    rootDrive = "/dev/nvme0n1";
    users.robin = { };
  };

  den.aspects.pewter = {
    includes = with den.aspects; [
      disko
      disko._.btrfs-root

      limine
      plymouth
      zram
      bluetooth

      locale._.de
      desktop
      fprintd._.validity
      niri
      niri._.dux
      kanshi._.laptop
      dux

      development
      podman
      image-editing
      audio-editing
    ];

    nixos = { ... }: {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
      ];

      boot = {
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "nvme"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ ];
        };

        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      hardware = {
        bluetooth.enable = true;
      };

      services = {
        power-profiles-daemon.enable = true;
      };
    };
  };
}
