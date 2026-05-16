{ den, ... }: {
  den.aspects.desktop = {
    includes = with den.aspects; [
      pipewire
      firefox
      nemo
      kitty
    ];

    nixos =
      { pkgs, ... }:
      {
        boot.kernelPackages = pkgs.linuxPackages_zen;

        services = {
          # For udiskie (auto-mounting drives)
          udisks2.enable = true;
          # For gammastep (red filter at night)
          geoclue2.enable = true;

          accounts-daemon.enable = true;
          upower.enable = true;
          gvfs.enable = true;
        };

        # Use NetworkManager on desktop
        networking.networkmanager.enable = true;
      };

    homeManager = { pkgs, ... }: {
      xdg = {
        autostart.enable = true;

        mimeApps = {
          enable = true;

          # Set default applications
          defaultApplicationPackages = with pkgs; [
            mpc-qt
            image-roll
          ];
        };

        userDirs = {
          enable = true;
          createDirectories = true;
          setSessionVariables = true;
        };
      };

      home.packages = with pkgs; [
        # Media players
        mpc-qt
        vlc

        # Image viewer
        image-roll
      ];

      programs = {
        # Document viewer
        zathura.enable = true;
      };

      services = {
        gammastep = {
          enable = true;
          provider = "geoclue2";
        };

        udiskie = {
          enable = true;

          settings = {
            program_options = {
              menu = "flat";
              file_manager = "xdg-open";
            };
          };
        };
      };
    };
  };
}
