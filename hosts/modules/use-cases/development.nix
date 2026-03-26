{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  users = config.sunner.users;
  cfg = config.sunner.useCases.development;
in
{
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

    users.users = lib.mapAttrs (username: _: {
      extraGroups = [
        "podman"
      ];
    }) users;
  };
}
