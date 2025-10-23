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
        fastfetch
        krabby

        nemo-with-extensions
        mpc-qt
        image-roll
      ];

      stateVersion = "25.05";
    };

    programs = {
      home-manager.enable = true;

      zsh = {
        enable = true;

        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        defaultKeymap = "emacs";
      };

      starship = {
        enable = true;
        enableZshIntegration = true;      
      };

      kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
        font = {
          name = "FiraCodeNFM-Reg"; # TODO: idk what it's called actually
          package = pkgs.nerd-fonts.fira-code;
        };

        settings = {
          background_opacity = 0.75;
          window_padding_width = 8;

          cursor_shape = "beam";
        };
      };

      firefox.enable = true;
      gpg.enable = true;
    };

    stylix.enable = false;

    xdg = {
      systemDirs.data = [
        "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
      ];

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
