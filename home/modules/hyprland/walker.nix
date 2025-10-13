{ config, inputs, ... }: {
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = config.sunner.hyprland.enable;
    runAsService = true;

    config = {
      providers.prefixes = [
        { provider = "websearch"; prefix = "?"; }
      ];
    };
  };
}
