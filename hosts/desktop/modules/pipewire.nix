{ pkgs, ... }: {
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
