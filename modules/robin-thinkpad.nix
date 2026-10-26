{
  inputs,
  self,
  den,
  ...
}:
{
  den.aspects.robin-thinkpad = {
    includes = with den.aspects; [
      disko
      disko._.btrfs-root

      limine
      plymouth
      zram
      bluetooth

      locale-de
      desktop
      niri
      niri._.dux
      kanshi._.laptop
      dux

      development
      image-editing
      audio-editing
    ];

    nixos = { pkgs, ... }: {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
        self.nixosModules.open-fprintd
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
        open-fprintd = {
          enable = true;
          pamServices = [
            "login"
            "greetd"
          ];

          validity.enable = true;
        };
      };
    };
  };
}
