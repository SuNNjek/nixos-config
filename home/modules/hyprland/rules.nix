{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Launch Firefox PiP in floating mode and pin it
      "tag +pip, class:firefox, title:Picture-in-Picture"
      "tag +pip, class:firefox, title:Bild-im-Bild"
      
      "float, tag:pip"
      "pin, tag:pip"
      "content video, tag:pip"

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
    ];

    layerrule = [
      "blur, ^quickshell(:.*)?"
      "ignorealpha 0.25, ^quickshell(:.*)?"

      "dimaround, quickshell:modal"
    ];


    workspace = [
      "1, monitor:desc:Dell Inc. DELL U2724DE 6QZ59P3, default:true"
    ];
  };
}
