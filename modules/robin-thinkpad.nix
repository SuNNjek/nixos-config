{ inputs, den, ... }:
{
  den.aspects.robin-thinkpad = {
    includes = with den.aspects; [
      limine
      plymouth
      zram
      bluetooth

      locale-de
      desktop
      hyprland
      dms

      development
      image-editing
      audio-editing
    ];

    nixos = {
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
    };
  };
}
