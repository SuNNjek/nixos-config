{ lib, config, ... }:
let
  inherit (lib) mkForce;
  inherit (config.stylix) fonts;
in {
  programs.hyprlock = {
    enable = config.sunner.hyprland.enable;

    settings = {
      "$font" = fonts.sansSerif.name;

      general = {
        hide_cursor = false;
      };

      background = {
        path = mkForce "screenshot";
        blur_passes = 3;
      };
    
      input-field = {
        size = "50%, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        outline_thickness = 5;
        placeholder_text = "Passwort";
        font_family = "$font";
        shadow_passes = 2;
      };

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_family = "$font";
          font_size = 48;
          position = "0, -200";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = ''cmd[update:60000] date "+%x"'';
          font_family = "$font";
          font_size = 16;
          position = "0, -275";
          halign = "center";
          valign = "top";
        }
      ];
    };
  };
}
