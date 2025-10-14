{ lib, pkgs, ... }: let
  inherit (lib.meta) getExe;

  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  grimblast = getExe pkgs.grimblast;

  workspaceCount = 9;
  forWorkspace = f: builtins.concatLists (builtins.genList (ws: f (ws + 1)) workspaceCount);
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = [
      "$mod, T, exec, $terminal"
      "$mod, F, fullscreen"
      
      ", print, exec, ${grimblast} --notify copy area"
      "CTRL, print, exec, ${grimblast} --notify copy screen"
      
      "$mod, Q, killactive"

      "$mod, L, exec, dms ipc call lock lock"
      "$mod, SPACE, exec, dms ipc call spotlight toggle"
      "$mod, V, exec, dms ipc call clipboard toggle"
      "$mod, N, exec, dms ipc call notepad toggle"
      "$mod SHIFT, Q, exec, dms ipc call powermenu toggle"

      "$mod, left, workspace, r-1"
      "$mod, right, workspace, r+1"
      "$mod SHIFT, left, movetoworkspace, r-1"
      "$mod SHIFT, right, movetoworkspace, r+1"
    ]
    ++ forWorkspace (ws: [
      "$mod, ${toString ws}, workspace, ${toString ws}"
      "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
    ]);

    # $mod + Left Mouse to move the active window
    # $mod + Right Mouse to resize it
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    # $mod + Middle Mouse (=scrollwheel click) to toggle floating of current window
    bindc = [
      "$mod, mouse:274, togglefloating"
    ];

    bindl = [
      ", switch:on:Lid Switch, exec, ${hyprctl} keyword monitor \"eDP-1,disable\""
      ", switch:off:Lid Switch, exec, ${hyprctl} keyword monitor \"eDP-1,highres,auto,1\""

      ", XF86AudioMute, exec, dms ipc call audio mute"
      ", XF86AudioPlay, exec, dms ipc call mpris playPause"
    ];

    bindle = [
      ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 5"
      ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 5"
    ];

    gesture = [
      "3, horizontal, workspace"
    ];
  };
}
