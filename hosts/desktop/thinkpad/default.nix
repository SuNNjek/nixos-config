{ lib, pkgs, ... }:
let 
  inherit (lib) mkForce;
in {
  imports = [
    ../.
    ./hardware-configuration.nix

    ../../modules/zram.nix

    ../modules/regreet.nix
  ];

  boot.loader = {
    grub.enable = mkForce false;
    limine.enable = true;
  };

  environment.systemPackages = with pkgs; [
    limine
  ];

  sunner.diskLayout = {
    btrfs = {
      enable = true;
      device = "/dev/nvme0n1";
    };

    tmp.enable = true;
  };

  services = {
    power-profiles-daemon.enable = true;
  };

  networking = {
    hostName = "robin-thinkpad";
  };
}
