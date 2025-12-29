{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Launch Firefox PiP in floating mode and pin it
      "tag +pip, class:firefox, title:Picture-in-Picture"
      "tag +pip, class:firefox, title:Bild-im-Bild"
      
      "float, tag:pip"
      "pin, tag:pip"
      "keepaspectratio on, tag:pip"
      "content video, tag:pip"

      "content game, class:^(steam_app.*|steam_app_\d+)$"
      "content game, class:^(gamescope)$"

      "noborder 1,content:game"
      "noshadow,content:game"
      "noblur,content:game"
      "noanim,content:game"
      "syncfullscreen,content:game"

      # Move all windows launched by tray/waybar modules
      # to the bottom right corner
      "tag +tray, class:org.pulseaudio.pavucontrol"
    ];

    layerrule = [
      "blur, ^(dms|quickshell)(:.*)?"
      "blurpopups, ^(dms|quickshell)(:.*)?"
      "ignorealpha 0.25, ^(dms|quickshell)(:.*)?"

      "dimaround, (dms|quickshell):modal"
    ];
  };
}
