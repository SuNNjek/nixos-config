{
  lib,
  osConfig,
  inputs,
  pkgs,
  ...
}:
with lib;
let
  cfg = osConfig.sunner.mango;

  tagCount = 9;
  forTag = f: builtins.concatLists (builtins.genList (tag: f (toString (tag + 1))) tagCount);
in {
  imports = [
    inputs.mango.hmModules.mango
  ];

  config = mkIf cfg.enable {
    systemd.user.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    wayland.windowManager.mango = {
      enable = true;
      settings = concatLines ([
        "exec-once=uwsm finalize"
        "exec-once=${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all"

        "source=./dms/colors.conf"
        "source=./dms/cursor.conf"
        "source=./dms/layout.conf"

        "blur=1"
        "blur_layer=1"
        "enable_hotarea=0"

        "xkb_rules_layout=de"
        "trackpad_natural_scrolling=1"

        "syncobj_enable=1"
        "allow_tearing=2"

        "bind=SUPER,T,spawn,kitty"
        "bind=SUPER,B,spawn,firefox"
        "bind=SUPER,F,togglefullscreen"
        
        "bind=SUPER,Q,killclient"
        "bind=SUPER,L,spawn,dms ipc call lock lock"
        "bind=SUPER,space,spawn,dms ipc call spotlight toggle"
        "bind=SUPER,Tab,toggleoverview"
        "bind=SUPER,V,spawn,dms ipc call clipboard toggle"
        "bind=SUPER,N,spawn,dms ipc call notepad toggle"
        "bind=SUPER+SHIFT,Q,spawn,dms ipc call powermenu toggle"

        "bind=SUPER,Left,viewtoleft"
        "bind=SUPER,Right,viewtoright"
        "bind=SUPER+SHIFT,Left,tagtoleft"
        "bind=SUPER+SHIFT,Right,tagtoright"

        "bind[l]=none,XF86AudioMute,spawn,dms ipc call audio mute"
        "bind[l]=none,XF86AudioPlay,spawn,dms ipc call audio playPause"
        "bind[l]=none,XF86AudioRaiseVolume,spawn,dms ipc call audio increment 5"
        "bind[l]=none,XF86AudioLowerVolume,spawn,dms ipc call audio increment 5"

        "bind[l]=none,XF86MonBrightnessUp,spawn,dms ipc call brightness increment 5"
        "bind[l]=none,XF86MonBrightnessDown,spawn,dms ipc call brightness decrement 5"

        "mousebind=SUPER,btn_left,moveresize,curmove"
        "mousebind=SUPER,btn_right,moveresize,curresize"
        "mousebind=SUPER,btn_middle,togglefloating"

        "gesturebind=none,left,3,viewtoleft"
        "gesturebind=none,right,3,viewtoright"
        "gesturebind=none,up,3,dms ipc call spotlight open"
        "gesturebind=none,down,3,dms ipc call spotlight close"
        "gesturebind=none,up,4,toggleoverview"
      ] ++ forTag (tag: [
        "bind=SUPER,${tag},view,${tag}"
        "bind=SUPER+SHIFT,${tag},tag,${tag}"
      ]));
    };

    services = {
      gammastep = {
        enable = true;
        provider = "geoclue2";
      };

      udiskie = {
        enable = true;

        settings = {
          program_options = {
            menu = "flat";
            file_manager = "xdg-open";
          };
        };
      };
    };
  };
}
