{ config, ... }: let
  waybarHeight = config.programs.waybar.settings.mainBar.height;
in
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Give kitty some transparency
      "opacity 0.75, class:kitty"

      # Launch Firefox PiP in floating mode and pin it
      "tag +pip, class:firefox, title:Picture-in-Picture"
      "tag +pip, class:firefox, title:Bild-im-Bild"
      
      "float, tag:pip"
      "pin, tag:pip"
      "content video, tag:pip"
      "move 100%-w-8 100%-w-${toString (waybarHeight + 8)}, tag:pip"

      "tag +games, content:game"
      "tag +games, class:^(steam_app.*|steam_app_\d+)$"
      "tag +games, class:^(gamescope)$"

      "content game,tag:games"
      "noborder 1,tag:games"
      "noshadow,tag:games"
      "noblur,tag:games"
      "noanim,tag:games"
      "syncfullscreen,tag:games"

      # Move all windows launched by tray/waybar modules
      # to the bottom right corner
      "tag +tray, class:org.pulseaudio.pavucontrol"
      "float, tag:tray"
      "pin, tag:tray"
      "move 100%-w-8 100%-w-${toString (waybarHeight + 8)}, tag:tray"

      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"
    ];

    layerrule = [
      "blur, waybar"
      
      "blur, notifications"
      "ignorezero, notifications"

      "dimaround, walker"
      "blur, walker"
    ];

    workspace = [
      "w[tv1], gapsin:0, gapsout:0"
      "f[1], gapsin:0, gapsout:0"

      "1, monitor:desc:Dell Inc. DELL U2724DE 6QZ59P3, default:true"
    ];
  };
}
