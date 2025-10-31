{ lib, osConfig, config, pkgs, ... }:
with lib;
let
  cfg = config.sunner.kanshi;

  setPrimaryMonitor = pkgs.callPackage ./set-primary-monitor.nix {};
in {
  options = {
    sunner.kanshi.enable = mkOption {
      type = types.bool;
      description = "Whether to enable kanshi";
      default = osConfig.sunner.hyprland.enable;
    };
  };

  config = {
    services.kanshi ={
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
            criteria = "Dell Inc. DELL U2724DE 6QZ59P3";
            alias = "mainMonitor";
            mode = "2560x1440";
          };
        }
        {
          output = {
            criteria = "Dell Inc. DELL P2225H DNWN504";
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
            exec = "${getExe setPrimaryMonitor} \"Dell Inc. DELL U2724DE 6QZ59P3\"";
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
            exec = "${getExe setPrimaryMonitor} \"Dell Inc. DELL U2724DE 6QZ59P3\"";
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
