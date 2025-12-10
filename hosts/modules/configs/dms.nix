{ inputs, lib, config, ... }:
with lib;
let
  cfg = config.sunner.dms;
  cursorCfg = config.stylix.cursor;
in {
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  config = {
    environment.sessionVariables = {
      XDG_DATA_DIRS = [ "${cursorCfg.package}/share" ];
      XCURSOR_PATH = [ "${cursorCfg.package}/share/icons" ];
    };

    programs.dankMaterialShell.greeter = {
      enable = cfg.enable;
      configHome = mkIf (cfg.greeter.configUser != null)
        "/home/${cfg.greeter.configUser}";

      compositor = {
        name = "hyprland";
        customConfig = ''
          env = HYPRCURSOR_THEME,${cursorCfg.name}
          env = XCURSOR_THEME,${cursorCfg.name}

          env = HYPRCURSOR_SIZE,${toString cursorCfg.size}
          env = XCURSOR_SIZE,${toString cursorCfg.size}

          animations {
            enabled = false
          }

          input {
            kb_layout = de
          }

          misc {
            disable_hyprland_logo = true
          }

          monitor = desc:Dell Inc. DELL U2724DE 6QZ59P3,highres,0x0,1
          monitor = desc:Dell Inc. DELL P2225H DNWN504,highres,auto-right,1,transform,3
          monitor = ,highres,auto,1

          workspace = 1, m:desc:Dell Inc. DELL U2724DE 6QZ59P3, default:true
        '';
      };
    };
  };
}
