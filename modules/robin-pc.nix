{ inputs, den, ... }:
{
  den.aspects.robin-pc = {
    includes = with den.aspects; [
      limine
      zram

      desktop
      hyprland
      dms

      gaming

      video-editing
      video-editing._.recording

      image-editing

      audio-editing
      audio-editing._.recording
    ];

    nixos = {
      imports = with inputs.nixos-hardware.nixosModules; [
        common-cpu-amd
        common-cpu-amd-pstate
        common-gpu-amd
        common-pc
        common-pc-ssd
      ];

      boot = {
        extraModulePackages = [ ];
        kernelModules = [ "kvm-amd" ];

        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "nvme"
            "ahci"
            "thunderbolt"
            "usb_storage"
            "usbhid"
            "sd_mod"
            "sr_mod"
          ];
        };
      };

      hardware = {
        bluetooth.enable = true;
      };

      services.hardware.openrgb.enable = true;
    };
  };
}
