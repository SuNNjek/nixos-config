{ lib, ... }:
with lib;
let
  sudoConfig = with types; submodule {
    options = {
      enable = mkEnableOption "sudo";
      withoutPassword = mkEnableOption "without password";
    };
  };

  userConfig = with types; submodule {
    options = {
      configPath = mkOption {
        type = path;
        description = "Path to the user config";
      };

      sudo = mkOption {
        type = sudoConfig;
        description = "Sudo config";
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
