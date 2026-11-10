{ inputs, den, ... }:
{
  #
  # "The biggest city in Kanto, shining with a golden light."
  #
  # Main PC with the biggest specs in config, shining with some RGB.
  #

  den.hosts.x86_64-linux.saffron = {
    rootDrive = "/dev/nvme1n1";
    users.robin = { };
  };

  den.aspects.saffron = {
    includes = with den.aspects; [
      disko
      disko._.btrfs-root

      limine
      plymouth
      zram
      bluetooth

      locale._.de
      desktop
      niri
      niri._.dux
      kanshi._.pc
      dux
      howdy

      matugen._.openrgb

      development
      podman
      gaming

      video-editing
      video-editing._.recording

      image-editing

      audio-editing
      audio-editing._.recording

      (den.batteries.unfree [ "makemkv" ])
    ];

    nixos = { ... }: {
      imports = with inputs.nixos-hardware.nixosModules; [
        common-cpu-amd
        common-cpu-amd-pstate
        common-gpu-amd
        common-pc
        common-pc-ssd
      ];

      boot = {
        extraModulePackages = [ ];
        kernelModules = [
          "kvm-amd"
          "sg"
        ];

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
        keyboard.qmk.enable = true;
      };

      services.hardware.openrgb.enable = true;
    };

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        kdePackages.k3b
        makemkv
      ];
    };
  };
}
