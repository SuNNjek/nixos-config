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
    
    limine = {
      enable = true;

      extraEntries = ''
        /Windows
          protocol: efi
          path: uuid(7006ed1b-b7fa-40ec-92af-fd0fae8ef4e2):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    limine
  ];

  services = {
    hardware.openrgb.enable = true;
  };

  sunner.diskLayout = {
    btrfs = {
      enable = true;
      device = "/dev/nvme1n1";
    };

    tmp = {
      enable = true;
      size = "8G";
    };
  };

  networking = {
    hostName = "robin-pc";
  };
}
