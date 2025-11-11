{ inputs, config, osConfig, ... }: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = osConfig.sunner.flatpak.enable;

    update.auto = {
      enable = true;
    };

    overrides = {
      global = {
        Context.filesystems = [
          "/nix/store:ro"

          # Theming
          "xdg-config/fontconfig:ro"
          "xdg-config/gtkrc:ro"
          "xdg-config/gtkrc-2.0:ro"
          "xdg-config/gtk-2.0:ro"
          "xdg-config/gtk-3.0:ro"
          "xdg-config/gtk-4.0:ro"
          "xdg-data/themes:ro"
          "xdg-data/icons:ro"
        ];
      };
    };
  };

  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
  ];
}
