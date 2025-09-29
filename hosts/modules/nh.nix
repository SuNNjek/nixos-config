{ lib, config, ... }: {
  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };

  environment.variables = {
    "HOSTNAME" = lib.mkDefault config.networking.hostName;
  };
}
