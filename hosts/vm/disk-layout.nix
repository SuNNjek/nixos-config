{ lib, disko, ... }: {
    disko.devices = {
        disk.main = {
            type = "disk";
            device = "/dev/sda";
            content = {
                type = "gpt";
                partitions = {
                    ESP = {
                        priority = 1;
                        name = "ESP";
                        start = "1M";
                        end = "1G";
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
                                "@nix" = {
                                    mountpoint = "/nix";
                                    mountOptions = [
                                        "compress=zstd"
                                        "noatime"
                                    ];
                                };

                                "@etc" = {
                                    mountpoint = "/etc";
                                    mountOptions = [
                                        "compress=zstd"
                                        "noatime"
                                    ];
                                };

                                "@home" = {
                                    mountpoint = "/home";
                                    mountOptions = [ "compress=zstd" ];
                                };

                                "@log" = {
                                    mountpoint = "/var/log";
                                    mountOptions = [
                                        "compress=zstd"
                                        "noatime"
                                    ];
                                };

                                "@cache" = {
                                    mountpoint: "/var/cache";
                                    mountOptions = [
                                        "compress=zstd"
                                        "noatime"
                                    ];
                                };
                            };
                        };
                    };
                };
            };
        };

        nodev = {
            "/" = {
                fsType = "tmpfs";
                mountOptions = [
                    "size=2G"
                    "defaults"
                    "mode=755"
                ];
            };
        };
    };
}