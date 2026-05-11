{ lib, ... }:
with lib;
{
  options = {
    sunner.zram = {
      enable = mkEnableOption "ZRAM";
    };
  };
}
