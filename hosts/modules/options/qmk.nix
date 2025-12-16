{ lib, ... }:
with lib;
{
  options = {
    programs.qmk = {
      enable = mkEnableOption "QMK";
      enableVia = mkEnableOption "VIA";
    };
  };
}
