{ lib, pkgs, ... }:
with lib;
let
  userConfig =
    with types;
    submodule {
      options = {
        shell = mkPackageOption pkgs "User shell" {
          default = "zsh";
        };

        sudo = {
          enable = mkEnableOption "sudo";
          withoutPassword = mkEnableOption "without password";
        };

        homeManager = {
          enable = mkEnableOption "Home manager";

          configPath = mkOption {
            type = path;
            description = "Path to the user config";
          };
        };
      };
    };
in
{
  options = {
    sunner.users = mkOption {
      type = with types; attrsOf userConfig;
      description = "User to add to the system";
      default = { };
    };
  };
}
