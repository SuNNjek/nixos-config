{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Interesting naming there... it sure is... redundant
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default

    ./matugen.nix
  ];

  home = {
    packages = with pkgs; [
      pywalfox-native
    ];

    pointerCursor = {
      gtk.enable = true;

      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };

  programs = {
    dankMaterialShell = {
      enable = true;
      enableSystemd = true;
    };

    kitty.extraConfig = ''
      include dank-theme.conf
    '';
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.colloid-gtk-theme;
      name = "Colloid";
    };

    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid";
    };
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "qt6ct";
      package = pkgs.qt6ct;
    };
  };

  programs.firefox.nativeMessagingHosts = with pkgs; [ pywalfox ];
  xdg.cacheFile."wal/colors.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/dank-pywalfox.json";
}
