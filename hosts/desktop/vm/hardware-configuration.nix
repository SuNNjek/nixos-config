{ pkgs, ... }:
{
  boot.initrd.availableKernelModules = [
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_zen;

  nixpkgs.hostPlatform = "x86_64-linux";
  virtualisation.hypervGuest.enable = true;
}
