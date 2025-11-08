{ lib, osConfig, pkgs, ... }: let 
  cfg = osConfig.sunner.useCases.videoEditing;
in lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    kdePackages.kdenlive
    ffmpeg
  ];

  # That's kinda related to video editing, right?
  programs.obs-studio = {
    enable = true;

    package = with pkgs;
      if osConfig.hardware.nvidia.enabled then
        obs-studio-nvidia
      else
        obs-studio;
  };
}
