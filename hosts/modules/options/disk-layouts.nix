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
    };
  };
}
