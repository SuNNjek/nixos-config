{ lib, ... }:
with lib;
{
  options = {
    sunner.mango = {
      enable = mkEnableOption "MangoWC";
    };
  };
}
