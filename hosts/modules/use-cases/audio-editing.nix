{ lib, config, ... }:
let
  cfg = config.sunner.useCases.audioEditing;
in {
  options = with lib; {
    sunner.useCases = {
      audioEditing = {
        enable = mkEnableOption "Audio editing";

        fullDaws = {
          enable = mkEnableOption "Full DAWs";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.pipewire.jack.enable = true;
  };
}
