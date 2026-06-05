{ lib, ... }:
let
  joinKeys = keys: lib.join "+" keys;

  toBind = {
    keys,
    bind,
    keyOptions ? {},
    bindArgs ? []
  }: {
    ${joinKeys keys} = {
      _props = keyOptions;
      _children = [
        {
          ${bind} = bindArgs;
        }
      ];
    };
  };

  generateWorkspaceBinds = ws: [
    {
      keys = ["Mod" (toString ws)];
      bind = "focus-workspace";
      bindArgs = [ws];
    }

    {
      keys = ["Mod" "Shift" (toString ws)];
      bind = "move-column-to-workspace";
      bindArgs = [ws];
    }
  ];

  workspaceBinds = lib.flatten (lib.genList (ws: generateWorkspaceBinds (ws + 1)) 9);
in
{
  den.aspects.niri.provides.binds = {
    homeManager.programs.niri.config = {
      binds = {
        _children = lib.map toBind ([
          {
            keys = ["Mod" "Q"];
            keyOptions = {
              repeat = false;
            };
            bind = "close-window";
          }
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
            bind = "toggle-overview";
          }

          {
            keys = ["Mod" "C"];
            bind = "center-column";
          }
          {
            keys = ["Mod" "F"];
            bind = "maximize-column";
          }
          {
            keys = ["Mod" "Shift" "F"];
            bind = "fullscreen-window";
          }

          {
            keys = ["Mod" "R"];
            bind = "switch-preset-column-width";
          }
          {
            keys = ["Mod" "Shift" "R"];
            bind = "switch-preset-column-width-back";
          }

          {
            keys = ["Mod" "Left"];
            bind = "focus-column-left";
          }
          {
            keys = ["Mod" "WheelScrollUp"];
            bind = "focus-column-left";
          }
          {
            keys = ["Mod" "Shift" "Left"];
            bind = "move-column-left";
          }

          {
            keys = ["Mod" "Right"];
            bind = "focus-column-right";
          }
          {
            keys = ["Mod" "WheelScrollDown"];
            bind = "focus-column-right";
          }
          {
            keys = ["Mod" "Shift" "Right"];
            bind = "move-column-right";
          }

          {
            keys = ["Mod" "Up"];
            bind = "focus-window-up";
          }
          {
            keys = ["Mod" "Shift" "Up"];
            bind = "move-window-up";
          }

          {
            keys = ["Mod" "Down"];
            bind = "focus-window-down";
          }
          {
            keys = ["Mod" "Shift" "Down"];
            bind = "move-window-down";
          }

          {
            keys = ["Mod" "Page_Down"];
            bind = "focus-workspace-down";
          }
          {
            keys = ["Mod" "MouseBack"];
            bind = "focus-workspace-down";
          }
          {
            keys = ["Mod" "Shift" "Page_Down"];
            bind = "move-column-to-workspace-down";
          }

          {
            keys = ["Mod" "Page_Up"];
            bind = "focus-workspace-up";
          }
          {
            keys = ["Mod" "MouseForward"];
            bind = "focus-workspace-up";
          }
          {
            keys = ["Mod" "Shift" "Page_Up"];
            bind = "move-column-to-workspace-up";
          }

          {
            keys = ["Mod" "Comma"];
            bind = "consume-or-expel-window-left";
          }
          {
            keys = ["Mod" "Period"];
            bind = "consume-or-expel-window-right";
          }

          {
            keys = ["Mod" "V"];
            bind = "toggle-window-floating";
          }

          {
            keys = ["Print"];
            bind = "screenshot";
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

          {
            keys = [ "Mod" "T" ];
            bind = "spawn";
            bindArgs = [ "kitty" ];
          }

          {
            keys = [ "Mod" "B" ];
            bind = "spawn";
            bindArgs = [ "firefox" ];
          }
        ] ++ workspaceBinds);
      };
    };
  };
}
