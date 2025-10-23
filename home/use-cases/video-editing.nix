{ lib, osConfig, ... }: let 
  cfg = osConfig.sunner.host.useCases.videoEditing;
in lib.mkIf cfg.enable {
  # TODO
}
