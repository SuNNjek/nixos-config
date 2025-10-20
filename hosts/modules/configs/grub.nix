{ config, pkgs, ... }: let
  cfg = config.sunner.boot.grub;
in {
  boot.loader.grub = {
    inherit (cfg) enable device useOSProber;
    
    efiSupport = pkgs.stdenv.hostPlatform.isEfi;
  };
}
