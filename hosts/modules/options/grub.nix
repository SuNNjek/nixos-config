{ lib, ... }: 
with lib;
{
  options = {
    sunner.boot.grub = {
      enable = mkEnableOption "GRUB";
      useOSProber = mkEnableOption "OS prober";

      device = mkOption {
        type = types.str;
        description = "Device to install GRUB on";
        default = "nodev";
      };
    };
  };
}
