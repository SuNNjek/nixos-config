{
  den.aspects.zram = {
    nixos = {
      # Set kernel config to optimize swappiness and stuff for ZRAM
      # https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram
      boot = {
        kernel.sysctl = {
          "vm.swappiness" = 180;
          "vm.watermark_boost_factor" = 0;
          "vm.watermark_scale_factor" = 125;
          "vm.page-cluster" = 0;
        };

        tmp = {
          useZram = true;

          zramSettings = {
            compression-algorithm = "zstd";
            zram-size = "min(ram / 2, 8192)";
          };
        };
      };

      zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 50;
        memoryMax = 8192 * 1024 * 1024;
      };
    };
  };
}
