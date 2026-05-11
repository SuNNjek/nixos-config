{ lib, ... }:
with lib;
{
  options = {
    sunner.pipewire = {
      enable = mkEnableOption "Pipewire";
    };
  };
}
