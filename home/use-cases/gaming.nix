{ lib, osConfig, ... }: let 
  cfg = osConfig.sunner.host.useCases.gaming;
in lib.mkIf cfg.enable {
  xdg = {
    autostart.flatpaks = {
      "com.valvesoftware.Steam" = {
        enable = true;
        args = [ "-silent" ];
      };
    };
  };
}
