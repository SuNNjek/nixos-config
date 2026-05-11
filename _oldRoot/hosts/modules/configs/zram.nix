{ lib, config, ... }:
let
  cfg = config.sunner.zram;
in
lib.mkMerge [
  {
    zramSwap = {
      enable = cfg.enable;
      algorithm = "zstd";
      memoryPercent = 50;
      memoryMax = 8192 * 1024 * 1024;
    };
  }

  # Set kernel config to optimize swappiness and stuff for ZRAM
  # https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram
  (lib.mkIf cfg.enable {
    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  })
]
