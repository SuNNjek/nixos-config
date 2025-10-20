{ lib, config, ... }: let
  cfg = config.sunner.zram;
in {
  config = lib.mkMerge [
    {
      # Use zram-generator to generate some sweet ZRAM
      services.zram-generator = {
        enable = cfg.enable;
        settings.zram0 = {
          compression-algorithm = "zstd";
          zram-size = cfg.size;
        };
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
  ];
}
