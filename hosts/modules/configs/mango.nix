{ inputs, lib, config, ... }: let
  cfg = config.sunner.mango;
in {
  imports = [
    inputs.mango.nixosModules.mango
  ];

  config = {
    programs = {
      mango = {
        enable = cfg.enable;
      };

      uwsm = {
        enable = cfg.enable;

        waylandCompositors.mango = {
          prettyName = "MangoWC";
          comment = "MangoWC compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/mango";
        };
      };
    };

    services = {
      # For udiskie (auto-mounting drives)
      udisks2.enable = cfg.enable;
      # For gammastep (red filter at night)
      geoclue2.enable = cfg.enable;
    };
  };
}
