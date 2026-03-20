{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.nemo;
in
{
  options = {
    programs.nemo = {
      enable = mkEnableOption "Nemo file manager";
      package = mkPackageOption pkgs "nemo-with-extensions" { };
      terminal = mkPackageOption pkgs "kitty" { };

      actions = mkOption {
        default = {};
        type = with lib.types; attrsOf anything;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    dbus.packages = [ cfg.package ];

    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = getExe cfg.terminal;
      };
    };

    xdg.dataFile = 
    let
      iniFormat = pkgs.formats.ini {
        listToValue = atoms:
          atoms
          |> lib.map (atom: "${atom};")
          |> lib.concatStrings;
      };

      mapAction = (name: action: {
        name = "nemo/actions/${name}.nemo_action";
        value = {
          source = iniFormat.generate "${name}.nemo_action" {
            "Nemo Action" = action;
          };
        };
      });
    in lib.mapAttrs' mapAction cfg.actions;
  };
}
