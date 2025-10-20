{ lib, ... }:
with lib;
{
  options = {
    sunner.diskLayout = {
      btrfs = {
        enable = mkEnableOption "btrfs";

        device = mkOption {
          type = types.str;
          default = "/dev/sda";
          description = "Path of the root device";
        };
      };

      tmp = {
        enable = mkEnableOption "tmp";

        size = mkOption {
          type = types.str;
          default = "2G";
          description = "Size of /tmp";
        };
      };
    };
  };
}
