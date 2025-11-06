{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.programs.nemo;
in {
  options = {
    programs.nemo = {
      enable = mkEnableOption "Nemo file manager";
      package = mkPackageOption pkgs "nemo-with-extensions" {};
      terminal = mkPackageOption pkgs "kitty" {};
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    dbus.packages = [ cfg.package ];

    xdg.mimeApps = {
      defaultApplications = {
        "inode/directory" = [ "nemo.desktop" ];
      };
    };

    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = getExe cfg.terminal;  
      };
    };
  };
}
