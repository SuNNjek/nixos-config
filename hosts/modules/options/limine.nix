{ lib, ... }:
with lib;
{
  options = {
    sunner.boot.limine = {
      enable = mkEnableOption "Limine";
      enableStylix = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Stylix integration";
      };

      extraEntries = mkOption {
        type = types.separatedString;
        description = "Extra entries to append to the Limine config";
      };
    };
  };
}
