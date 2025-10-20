{ config, ... }: let
  cfg = config.sunner.pipewire;
in {
  security.rtkit.enable = cfg.enable;

  services.pipewire = {
    enable = cfg.enable;
    wireplumber.enable = true;
    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
