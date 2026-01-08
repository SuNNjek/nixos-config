{ lib, config, pkgs, ... }:
with lib;
let 
  cfg = config.sunner.useCases.development;
in {
  options = {
    sunner.useCases = {
      development = {
        enable = mkEnableOption "Development";
      };
    };
  };

  config = {
    environment.systemPackages = optional cfg.enable pkgs.podman-compose;

    virtualisation = {
      containers.registries = {
        search = [ "docker.io" ];
      };

      podman = {
        enable = cfg.enable;

        dockerSocket.enable = true;
        dockerCompat = true;

        autoPrune.enable = true;
      };
    };
  };
}
