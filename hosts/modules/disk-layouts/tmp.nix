{ lib, config, ... }:
with lib;
let
  cfg = config.diskLayout.tmp;
in
{
  options = {
    diskLayout.tmp = {
      enable = mkEnableOption "tmp";

      size = mkOption {
        type = types.str;
        default = "2G";
        defaultText = "2G";
        description = "Size of /tmp";
      };
    };
  };

  config = mkIf cfg.enable {
    disko.devices.nodev = {
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=${cfg.size}"
          "defaults"
          "mode=755"
        ];
      };
    };
  };
}
