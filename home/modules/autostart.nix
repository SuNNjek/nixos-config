{ lib, pkgs, config, ... }: let
  cfg = config.xdg.autostart.flatpaks;

  autostartEntry = with lib.types; submodule {
    options = {
      enable = lib.mkEnableOption "autostart";

      args = lib.mkOption {
        type = oneOf [
          (listOf str)
          str
        ];
        default = [];
        description = "Arguments to pass to the flatpak";
      };
    };
  };

  flatpak = lib.meta.getExe pkgs.flatpak;
in {
  options = {
    xdg.autostart.flatpaks = lib.mkOption {
      type = with lib.types; attrsOf autostartEntry;
      description = "Flatpaks to autostart with XDG Autostart";
      default = {};
    };
  };

  config = {
    xdg.configFile = lib.pipe cfg [
      (lib.filterAttrs (name: value: value.enable))
      (lib.mapAttrs' (name: value: {
        name = "autostart/flatpak-${name}.desktop";
        value = {
          text = ''
            [Desktop Entry]
            Type=Application
            Name=${name}
            Comment=${name} Flatpak autostart script
            Exec=${flatpak} run ${name} -- ${toString value.args}
          '';
        };
      }))
    ];
  };
}
