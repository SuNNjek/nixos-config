{ lib, ... }:
with lib;
{
  options = {
    sunner.zram = {
      enable = mkEnableOption "ZRAM";

      size = mkOption {
        type = types.str;
        description = "Size of the ZRAM";
        default = "min(ram / 2, 8192)";
      };
    };
  };
}
