{ config, pkgs, ... }: {
  imports = [
    ./modules
    ./use-cases
  ];

  # Default config for all users
  config = {
    home = {
      homeDirectory = "/home/${config.home.username}";

      packages = with pkgs; [
        krabby

        mpc-qt
        vlc
        image-roll
      ];

      stateVersion = "25.05";
    };

    programs = {
      home-manager.enable = true;
      nemo.enable = true;
      zathura.enable = true;

      nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/git/nixos-config";
      };

      zsh = {
        enable = true;

        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        defaultKeymap = "emacs";
      };

      starship = {
        enable = true;
      };

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

      firefox.enable = true;
      gpg.enable = true;
    };

    stylix.enable = false;

    xdg = {
      autostart.enable = true;

      mimeApps = {
        enable = true;

        # Set default applications
        defaultApplicationPackages = (with config.programs; [
          firefox.package
          nemo.package
        ]) ++ (with pkgs; [
          mpc-qt
          image-roll
        ]);
      };

      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };

    services = {
      gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-qt;
      };
    };
  };
}
