{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Launch Firefox PiP in floating mode and pin it
      "tag +pip, match:class firefox, match:title Picture-in-Picture"
      "tag +pip, match:class firefox, match:title Bild-im-Bild"

      "float on, pin on, keep_aspect_ratio on, content video, match:tag pip"

      "content game, match:class ^(steam_app.*|steam_app_\d+)$"
      "content game, match:class ^(gamescope)$"

      "no_shadow on, no_blur on, no_anim on, sync_fullscreen on, match:content game"
    ];

    layerrule = [
      "blur on, blur_popups on, ignore_alpha 0.25, match:namespace ^(dms|quickshell)(:.*)?"
      "dim_around on, match:namespace (dms|quickshell):modal"
    ];
  };
}
