{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dsearch.homeModules.default
    inputs.hypotd.homeManagerModules.default
  ];

  home = {
    packages = with pkgs; [
      pywalfox-native
      grimblast
    ];
  };

  programs = {
    dank-material-shell = {
      enable = true;
      systemd.enable = true;
    };

    hypotd = {
      enable = true;

      config = {
        provider = "bing";
        customCommand = "dms ipc call wallpaper set {{.Path}}";
      };
    };

    dsearch = {
      enable = true;

      config = {
        indexPaths = [
          {
            path = config.xdg.userDirs.pictures;
            max_depth = 0;
            extract_exif = true;
          }
        ];
      };
    };

    kitty.extraConfig = ''
      include dank-theme.conf
      include dank-tabs.conf
    '';
  };

  services = {
    cliphist.enable = true;
  };

  wayland.windowManager.hyprland.settings.source = [
    "~/.config/hypr/dms/colors.conf"
    "~/.config/hypr/dms/cursor.conf"
    "~/.config/hypr/dms/layout.conf"
  ];

  gtk =
    let
      extraCss = ''
        @import url("dank-colors.css");
      '';
    in
    {
      enable = true;

      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };

      iconTheme = {
        package = pkgs.vimix-icon-theme;
        name = "Vimix-dark";
      };

      gtk3.extraCss = extraCss;
      gtk4.extraCss = extraCss;
    };

  qt = {
    enable = true;
    platformTheme = {
      name = "qtct";
      package = with pkgs; [
        libsForQt5.qt5ct
        qt6Packages.qt6ct
      ];
    };
  };

  programs.firefox.nativeMessagingHosts = with pkgs; [ pywalfox ];
  xdg.cacheFile."wal/colors.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/dank-pywalfox.json";
}
