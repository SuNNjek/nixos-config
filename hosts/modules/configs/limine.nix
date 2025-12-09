{ lib, pkgs, config, ... }: let
  cfg = config.sunner.boot.limine;
in lib.mkMerge [
  {
    boot.loader.limine = {
      enable = cfg.enable;

      # Should be enough and doesn't spam the boot menu
      maxGenerations = 5;

      extraConfig = "quiet: yes";
    };
  }

  (lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      limine
    ];
  })
]
