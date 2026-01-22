{
  lib,
  osConfig,
  pkgs,
  ...
}:
with lib;
let
  cfg = osConfig.sunner.useCases.audioEditing;
in
mkIf cfg.enable (mkMerge [
  {
    home.packages = with pkgs; [
      audacity
    ];
  }

  (mkIf cfg.fullDaws.enable {
    home.packages = with pkgs; [
      ardour
    ];
  })
])
