{ inputs, config, osConfig, ... }: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = osConfig.sunner.flatpak.enable;

    update.auto = {
      enable = true;
    };
  };

  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
  ];
}
