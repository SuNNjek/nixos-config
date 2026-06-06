{ lib, ... }:
let
  niriLib = import ./_lib.nix { inherit lib; };
in
{
  den.aspects.niri.provides.dms = { host, ... }: {
    nixos = {
      programs.dank-material-shell.greeter.compositor = {
        name = lib.mkForce "niri";
        customConfig = lib.mkForce ''
          input {
            touchpad {
              tap
              natural-scroll
            }
          }

          hotkey-overlay {
            skip-at-startup
          }

          cursor {
            xcursor-theme "Bibata-Modern-Ice"
            xcursor-size 24
          }

          output "Dell Inc. DELL P2225H DNWN504" {
            transform "270"
          }
        '';
      };
    };

    homeManager.programs.niri.config = {
      binds = {
        _children = lib.map niriLib.toBind [
          {
            keys = ["Mod" "Shift" "Q"];
            keyOptions = {
              repeat = false;
            };
            bind = "spawn";
            bindArgs = [ "dms" "ipc" "call" "powermenu" "toggle" ];
          }
          {
            keys = ["Mod" "L"];
            keyOptions = {
              repeat = false;
            };
            bind = "spawn";
            bindArgs = [ "dms" "ipc" "call" "lock" "lock" ];
          }

          {
            keys = ["Mod" "Space"];
            keyOptions = {
              repeat = false;
            };
            bind = "spawn";
            bindArgs = [ "dms" "ipc" "call" "spotlight" "toggle" ];
          }


          {
            keys = [ "XF86AudioRaiseVolume" ];
            keyOptions = {
              allow-when-locked = true;
            };
            bind = "spawn";
            bindArgs = [ "dms" "ipc" "call" "audio" "increment" "5" ];
          }
          {
            keys = [ "XF86AudioLowerVolume" ];
            keyOptions = {
              allow-when-locked = true;
            };
            bind = "spawn";
            bindArgs = [ "dms" "ipc" "call" "audio" "decrement" "5" ];
          }
          {
            keys = [ "XF86AudioMute" ];
            keyOptions = {
              allow-when-locked = true;
            };
            bind = "spawn";
            bindArgs = [ "dms" "ipc" "call" "audio" "mute" ];
          }
          {
            keys = [ "XF86AudioPlay" ];
            keyOptions = {
              allow-when-locked = true;
            };
            bind = "spawn";
            bindArgs = [ "dms" "ipc" "call" "mpris" "playPause" ];
          }
        ];
      };
    };
  };
}
