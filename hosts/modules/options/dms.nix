{ lib, ... }:
with lib;
{
  options = {
    sunner.dms = {
      enable = mkEnableOption "Material Shell";

      greeter = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Whether or not to use the Material Shell greeter";
        };

        configUser = mkOption {
          type = with types; nullOr str;
          default = null;
          description = "Username of the user to copy the config from";
        };
      };
    };
  };
}
