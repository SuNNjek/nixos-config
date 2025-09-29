{ lib, pkgs, config, ... }:
let
  inherit (lib) mkDefault;


  inherit (config.lib.stylix) colors;
  wallpaper = config.stylix.image;
in {
  # Set default options for bootloaders, but don't enable them here
  boot.loader = {
    efi.canTouchEfiVariables = pkgs.stdenv.hostPlatform.isEfi;

    # I feel like all of these could depend on the system to use, so use mkDefault everywhere
    grub = {
      efiSupport = pkgs.stdenv.hostPlatform.isEfi;
      device = mkDefault "nodev";
    
      useOSProber = mkDefault false;
    };

    limine = {
      # Should be enough and doesn't spam the boot menu
      maxGenerations = 5;

      # No stylix support yet, so do it manually
      style = {
        wallpapers = [ wallpaper ];
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
      };
    };
  };
}
