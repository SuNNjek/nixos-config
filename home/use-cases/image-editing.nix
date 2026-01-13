{ lib, osConfig, pkgs, ... }: let 
  cfg = osConfig.sunner.useCases.imageEditing;
in lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    gimp3-with-plugins
    imagemagick
  ];
}
