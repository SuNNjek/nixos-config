{ lib, pkgs, inputs, ... }: let
  inherit (lib) getExe getExe';

  regreetHyprlandConfig = pkgs.writeText "regreet-hyprland-config" ''
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

    exec-once = ${lib.getExe' pkgs.dbus "dbus-update-activation-environment"} --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE
    exec-once = ${getExe pkgs.regreet}; ${getExe' pkgs.hyprland "hyprctl"} dispatch exit
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
      compositor.name = "hyprland";
    };
  };

  services = {
    # For udiskie (auto-mounting drives)
    udisks2.enable = true;
    # For gammastep (red filter at night)
    geoclue2.enable = true;
  };
}
