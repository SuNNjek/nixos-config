{ den, ... }: {
  den.default.homeManager.imports = [
    (import ./_hm.nix)
  ];

  den.aspects.niri = {
    includes = with den.aspects.niri._; [
      binds
      rules
    ];

    nixos = {
      programs.niri.enable = true;
    };

    homeManager = {
      programs.niri = {
        enable = true;
        
        config = {
          prefer-no-csd = { };

          gestures = {
            hot-corners = {
              off = { };
            };
          };

          input = {
            touchpad = {
              tap = {};
              natural-scroll = {};
            };
          };

          layout = {
            center-focused-column = "on-overflow";

            default-column-width = {
              proportion = 0.5;
            };

            preset-column-widths = {
              _children = [
                { proportion = 1.0 / 3.0; }
                { proportion = 0.5; }
                { proportion = 2.0 / 3.0; }
              ];
            };
          };
        };
      };
    };
  };
}
