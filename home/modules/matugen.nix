{ osConfig, config, lib, pkgs, ... }: let
  tomlFormat = pkgs.formats.toml {};

  cfg = config.services.matugen;
in {
  # Little hack to get mkIf working
  options = with lib; {
    services.matugen = {
      templates = mkOption {
        type = with types; attrsOf anything;
        default = {};
      };
    };
  };

  config = {
    services.matugen.templates = {
      openrgb = lib.mkIf osConfig.services.hardware.openrgb.enable {
        input_path = "/dev/null";
        output_path = "/dev/null";
        post_hook = "${lib.getExe pkgs.openrgb} -m static -c {{colors.primary.default.hex_stripped}}";
      };
    };

    xdg.configFile."matugen/config.toml".source = tomlFormat.generate "matugen.toml" {
      config = {};
      inherit (cfg) templates;
    };
  };
}
