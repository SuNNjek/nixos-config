{ lib, pkgs, ... }:
with lib;
let
  userConfig = with types; submodule {
    options = {
      configPath = mkOption {
        type = path;
        description = "Path to the user config";
      };

      shell = mkPackageOption pkgs "User shell" {
        default = "zsh";
      };

      sudo = {
        enable = mkEnableOption "sudo";
        withoutPassword = mkEnableOption "without password";
      };
    };
  };
in {
  options = {
    sunner.homeManager = {
      enable = mkEnableOption "Home Manager";
      users = mkOption {
        type = with types; attrsOf userConfig;
        description = "Users to manage with Home Manager";
        default = { };
      };
    };
  }; 
}
