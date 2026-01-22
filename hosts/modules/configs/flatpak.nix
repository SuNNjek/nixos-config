{ inputs, config, ... }:
let
  cfg = config.sunner.flatpak;
in
{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak = {
    enable = cfg.enable;

    update.auto = {
      enable = true;
    };
  };
}
