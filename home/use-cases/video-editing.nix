{ lib, osConfig, ... }: let 
  cfg = osConfig.sunner.useCases.videoEditing;
in lib.mkIf cfg.enable {
  # TODO
}
