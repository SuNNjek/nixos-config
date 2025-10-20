{ lib, config, ... }:
with lib;
let
  cfg = config.sunner.diskLayout.tmp;
in
{
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
