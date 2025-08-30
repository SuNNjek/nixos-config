{ lib, pkgs, config, ... }: let
  inherit (lib) mkOption types getExe;
  inherit (lib.attrsets) mapAttrs';

  cfg = config.xdg.autostart;
in {
  options = {
    xdg.autostart = {
      flatpaks = mkOption {
        type = with types; attrs;
        description = ''
          Flatpaks to autostart with XDG Autostart
        '';
        default = {};
      };
    };
  };

  config = {
    xdg.configFile = (mapAttrs' (name: value: {
      name = "autostart/${name}.desktop";
      value = {
        text = ''
          [Desktop Entry]
          Name=${name}
          Type=Application
          Exec=${getExe pkgs.flatpak} run ${value.id} -- ${value.args or ""}
        '';
      };
    }) cfg.flatpaks);
  };
}
