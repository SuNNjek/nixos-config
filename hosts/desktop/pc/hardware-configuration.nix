{ inputs, lib, config, pkgs, ... }:
with lib;
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = [ ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [
      "module_blacklist=amdgpu"
      "initcall_blacklist=simpledrm_platform_driver_init"
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

      kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;

    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    
    bluetooth.enable = true;
  };
}
