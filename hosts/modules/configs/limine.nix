{ lib, pkgs, config, ... }: let
  cfg = config.sunner.boot.limine;
in lib.mkMerge [
  {
    boot.loader.limine = {
      enable = cfg.enable;

      # Should be enough and doesn't spam the boot menu
      maxGenerations = 5;

      # No stylix support yet, so do it manually
      style = lib.mkIf cfg.enableStylix (let
        inherit (config.lib.stylix) colors;
      in {
        wallpapers = [ config.stylix.image ];
        backdrop = colors.base00;

        graphicalTerminal = {
          palette = builtins.concatStringsSep "," (with colors; [
            "000000"
            red
            green
            brown
            blue
            magenta
            cyan
            "808080"
          ]);

          brightPalette = builtins.concatStringsSep "," (with colors; [
            "808080"
            bright-red
            bright-green
            brown
            bright-blue
            bright-magenta
            bright-cyan
            "FFFFFF"
          ]);
        };
      });
    };
  }

  (lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      limine
    ];
  })
]
