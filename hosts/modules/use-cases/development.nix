{ lib, config, ... }: let 
  cfg = config.sunner.useCases.development;
in {
  options = with lib; {
    sunner.useCases = {
      development = {
        enable = mkEnableOption "Development";
      };
    };
  };

  config = {
    virtualisation.podman = {
      enable = cfg.enable;

      dockerSocket.enable = true;
      dockerCompat = true;

      autoPrune.enable = true;
    };
  };
}
