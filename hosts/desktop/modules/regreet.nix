{ inputs, username, ... }: let
  regreetHyprlandConfig = ''
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
in {
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };

    dankMaterialShell.greeter = {
      enable = true;
      configHome = "/home/${username}";

      compositor = {
        name = "hyprland";
        customConfig = regreetHyprlandConfig;
      };
    };
  };

  services = {
    # For udiskie (auto-mounting drives)
    udisks2.enable = true;
    # For gammastep (red filter at night)
    geoclue2.enable = true;
  };
}
