{
  den.aspects.kitty = {
    homeManager = { pkgs, ... }: {
      programs.kitty = {
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

      xdg.terminal-exec = {
        enable = true;
        settings = {
          default = [
            "kitty.desktop"
          ];
        };
      };
    };
  };
}
