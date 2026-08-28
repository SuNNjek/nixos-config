{ lib, ... }@args:
let
  niriLib = import ./_lib.nix args;

  windowManagementBind =
    { keys, focus, focusArgs ? [], move, moveArgs ? [] }:
      keys
      |> lib.map (combo: [
          {
            keys = ([ "Mod" ] ++ combo);
            bind = focus;
            bindArgs = focusArgs;
          }
          {
            keys = [ "Mod" "Shift" ] ++ combo;
            bind = move;
            bindArgs = moveArgs;
          }
        ])
      |> lib.flatten;

  generateWorkspaceBinds = ws: windowManagementBind {
    keys = [[(toString ws)]];

    focus = "focus-workspace";
    focusArgs = [(toString ws)];
    move = "move-window-to-workspace";
    moveArgs = [(toString ws)];
  };
in
{
  den.aspects.niri.provides.binds = {
    homeManager.programs.niri.config = {
      binds =
        # General rules for binds:
        #
        # - Mostly should use the Mod key, binds without it should be sensible exceptions (PrintKey, volume keys, etc.)
        # - For window management stuff
        #   - Just Mod key plus directional keys/mouse keys controls focus on the current monitor
        #   - Mod + Alt controls focus across monitors
        #   - Mod + Page up/down or mouse back/forwards controls focus across workspaces
        #   - Mod + <number> moves focus to the workspace with the pressed number key, so Mod + 1 to focus the first workspace, Mod + 2 for the second, you get the idea
        #   - Mod + Comma/Period focuses the window "before/after" the current window.
        #     The direction here is from the top left to the bottom right, so a window to the left of or above another comes before it
        #   - Adding the Shift key modifies the layout. You can use all the other modifies as before, so Alt for moving between monitors for example, Comma/Period for moving windows into/out of columns, etc.
        #
        # Other binds:
        # Mod + Q: close current window
        # Mod + O: open overview
        # Mod + C: center column (I almost never use that one)
        # Mod + F: maximize the current column
        # Mod + Shift + F: make the current window fullscreen
        # Mod (+ Shift) + R: cycle through predefined column widths (currently 1/3, 1/2 and 2/3 of the screen width)
        # Mod + V: toggle floating for current window
        # Mod + T: open terminal (kitty)
        # Mod + B: open browser (firefox)
        let
          numberedWorkspace = lib.flatten (lib.genList (ws: generateWorkspaceBinds (ws + 1)) 9);

          columnLeft = windowManagementBind {
            keys = [ ["Left"] ["WheelScrollUp"] ];
            focus = "focus-column-left";
            move = "move-column-left";
          };

          columnRight = windowManagementBind {
            keys = [ ["Right"] ["WheelScrollDown"] ];
            focus = "focus-column-right";
            move = "move-column-right";
          };

          column = columnLeft ++ columnRight;

          windowLeft = windowManagementBind {
            keys = [ ["Comma"] ];
            focus = "focus-window-up-or-column-left";
            move = "consume-or-expel-window-left";
          };

          windowRight = windowManagementBind {
            keys = [ ["Period"] ];
            focus = "focus-window-down-or-column-right";
            move = "consume-or-expel-window-right";
          };

          windowUp = windowManagementBind {
            keys = [ ["Up"] ];
            focus = "focus-window-up";
            move = "move-window-up";
          };

          windowDown = windowManagementBind {
            keys = [ ["Down"] ];
            focus = "focus-window-down";
            move = "move-window-down";
          };

          window = windowLeft ++ windowRight ++ windowUp ++ windowDown;

          workspaceDown = windowManagementBind {
            keys = [["Page_Down"] ["MouseBack"]];
            focus = "focus-workspace-down";
            move = "move-column-to-workspace-down";
          };

          workspaceUp = windowManagementBind {
            keys = [["Page_Up"] ["MouseForward"]];
            focus = "focus-workspace-up";
            move = "move-column-to-workspace-up";
          };

          workspace = workspaceUp ++ workspaceDown ++ numberedWorkspace;

          monitorLeft = windowManagementBind {
            keys = [[ "Alt" "Left" ] [ "Alt" "WheelScrollUp" ]];
            focus = "focus-monitor-left";
            move = "move-column-to-monitor-left";
          };

          monitorRight = windowManagementBind {
            keys = [[ "Alt" "Right" ] [ "Alt" "WheelScrollDown" ]];
            focus = "focus-monitor-right";
            move = "move-column-to-monitor-right";
          };

          monitorUp = windowManagementBind {
            keys = [[ "Alt" "Up" ]];
            focus = "focus-monitor-up";
            move = "move-column-to-monitor-up";
          };

          monitorDown = windowManagementBind {
            keys = [[ "Alt" "Down" ]];
            focus = "focus-monitor-down";
            move = "move-column-to-monitor-down";
          };

          monitor = monitorLeft ++ monitorRight ++ monitorUp ++ monitorDown;
        in
        {
        _children = lib.map niriLib.toBind (
          window ++ column ++ workspace ++ monitor ++ [
          {
            keys = ["Mod" "Q"];
            keyOptions = {
              repeat = false;
            };
            bind = "close-window";
          }

          {
            keys = ["Mod" "O"];
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
            keys = ["Mod" "V"];
            bind = "toggle-window-floating";
          }

          {
            keys = ["Print"];
            bind = "screenshot";
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
        ]);
      };
    };
  };
}
