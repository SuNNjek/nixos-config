{ lib, ... }:
with lib;
{
  options = {
    sunner.flatpak = {
      enable = mkEnableOption "Flatpak";
    };
  };
}
