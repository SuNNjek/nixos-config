{
  lib,
  osConfig,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sunner.kanshi;

  setPrimaryMonitor = getExe (
    pkgs.writeShellApplication {
      name = "set-primary-monitor";

      runtimeInputs = with pkgs; [
        wlr-randr
        xrandr
        jq
      ];

      text = readFile ./set-primary-monitor.sh;
    }
  );

  hyprctl = "${pkgs.hyprland}/bin/hyprctl";

  mainMonitor = "Dell Inc. DELL U2724DE 6QZ59P3";
  sideMonitor = "Dell Inc. DELL P2225H DNWN504";
in
{
  options = {
    sunner.kanshi.enable = mkOption {
      type = types.bool;
      description = "Whether to enable kanshi";
      default = osConfig.sunner.hyprland.enable;
    };
  };

  config = {
    services.kanshi = {
      enable = cfg.enable;

      settings = [
        {
          output = {
            criteria = "eDP-1";
            alias = "laptopScreen";
          };
        }
        {
          output = {
            criteria = mainMonitor;
            alias = "mainMonitor";
            mode = "2560x1440";
          };
        }
        {
          output = {
            criteria = sideMonitor;
            alias = "sideMonitor";
            transform = "270";
            mode = "1920x1080";
          };
        }
        {
          profile = {
            name = "undocked";
            outputs = [
              {
                criteria = "$laptopScreen";
              }
            ];
          };
        }
        {
          profile = {
            name = "docked";
            exec = [
              "${setPrimaryMonitor} \"${mainMonitor}\""
              "${hyprctl} dispatch moveworkspacetomonitor 1 \"desc:${mainMonitor}\""
            ];
            outputs = [
              {
                criteria = "$laptopScreen";
                status = "disable";
              }
              {
                criteria = "$mainMonitor";
                position = "0,0";
              }
              {
                criteria = "$sideMonitor";
                position = "2560,0";
              }
            ];
          };
        }

        {
          profile = {
            name = "PC";
            exec = [
              "${setPrimaryMonitor} \"${mainMonitor}\""
              "${hyprctl} dispatch moveworkspacetomonitor 1 \"desc:${mainMonitor}\""
            ];
            outputs = [
              {
                criteria = "$mainMonitor";
                position = "0,0";
              }
              {
                criteria = "$sideMonitor";
                position = "2560,0";
              }
            ];
          };
        }
      ];
    };
  };
}
