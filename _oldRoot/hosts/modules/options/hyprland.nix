{ lib, ... }:
with lib;
{
  options = {
    sunner.hyprland = {
      enable = mkEnableOption "Hyprland";
    };
  };
}
