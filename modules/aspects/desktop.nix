{ den, ... }: {
  den.aspects.desktop = {
    includes = with den.aspects; [
      pipewire
      firefox
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
        };
      };

    homeManager = { pkgs, ... }: {
      xdg = {
        autostart.enable = true;

        terminal-exec = {
          enable = true;
          settings = {
            default = [
              "kitty.desktop"
            ];
          };
        };

        mimeApps = {
          enable = true;

          # Set default applications
          defaultApplicationPackages = with pkgs; [
            firefox
            nemo
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
        # File manager
        # nemo.enable = true;

        # Document viewer
        zathura.enable = true;

        # Terminal
        kitty = {
          enable = true;
          font = {
            name = "FiraCodeNFM-Reg";
            package = pkgs.nerd-fonts.fira-code;
          };

          settings = {
            background_opacity = 0.75;
            window_padding_width = 8;

            cursor_shape = "beam";
            cursor_trail = 3;
          };
        };
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
