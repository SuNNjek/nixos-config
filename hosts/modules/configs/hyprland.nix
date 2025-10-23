{ config, ... }: let
  cfg = config.sunner.hyprland;
in {
  programs = {
    hyprland = {
      enable = cfg.enable;
      withUWSM = cfg.enable;
    };
  };

  services = {
    # For udiskie (auto-mounting drives)
    udisks2.enable = cfg.enable;
    # For gammastep (red filter at night)
    geoclue2.enable = cfg.enable;
  };
}
