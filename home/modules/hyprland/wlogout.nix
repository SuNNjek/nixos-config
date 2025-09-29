{ config, ... }: {
  programs.wlogout = {
    enable = config.sunner.hyprland.enable;
  };
}
