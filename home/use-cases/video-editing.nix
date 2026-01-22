{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.sunner.useCases.videoEditing;
in
lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    kdePackages.kdenlive
    ffmpeg
    ccextractor
  ];

  # That's kinda related to video editing, right?
  programs.obs-studio = {
    enable = true;

    package = pkgs.obs-studio.override {
      cudaSupport = osConfig.hardware.nvidia.enabled;
    };
  };
}
