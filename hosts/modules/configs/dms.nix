{ inputs, lib, config, ... }: let
  cfg = config.sunner.dms;
in {
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  config = {
    programs.dankMaterialShell.greeter = {
      enable = true;
      configHome = lib.mkIf (cfg.greeter.configUser != null)
        "/home/${cfg.greeter.configUser}";

      compositor = {
        name = "hyprland";
        customConfig = ''
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
