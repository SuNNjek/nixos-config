{ lib, config, ... }:
with lib;
let
  cfg = config.sunner.diskLayout.btrfs;
in
mkIf cfg.enable {
  disko.devices.disk.main = {
    type = "disk";
    device = cfg.device;
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          priority = 1;
          name = "ESP";
          start = "1M";
          end = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        root = {
          size = "100%";
          name = "root";
          content = {
            type = "btrfs";

            subvolumes = {
              "@" = {
                mountpoint = "/";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };

              "@nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };

              "@var" = {
                mountpoint = "/var";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };

              "@home" = {
                mountpoint = "/home";
                mountOptions = [ "compress=zstd" ];
              };
            };
          };
        };
      };
    };
  };
}
