{ inputs, lib, pkgs, ... }: let
  inherit (lib) mkForce;
in {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "module_blacklist=amdgpu" ];
    extraModulePackages = [ ];

    # Force LTS kernel for NVIDIA build to succeed: https://github.com/NixOS/nixpkgs/issues/429624
    kernelPackages = mkForce pkgs.linuxPackages_6_12;

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

      kernelModules = [ ];
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;

    nvidia.open = true;
  };
}
