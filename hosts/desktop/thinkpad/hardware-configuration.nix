{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "kvm-intel"];
    extraModulePackages = [ ];
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;

    bluetooth.enable = true;
  };
}
