{ lib, ... }:
with lib;
{
  options = {
    sunner.stylix = {
      enable = mkEnableOption "Stylix";
    };
  };
}
