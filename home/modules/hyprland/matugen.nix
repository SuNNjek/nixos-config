{ pkgs, ... }: let
  tomlFormat = pkgs.formats.toml {};

  toPath = name: text: "${pkgs.writeText name text}";

  toTemplate = path: content: {
    input_path = toPath "input" content;
    output_path = path;
  };

in {
  xdg.configFile = {
    "matugen/config.toml".source = tomlFormat.generate "matugen.toml" {
      config = {};
      templates = {
        hyprland = toTemplate "~/.config/hypr/colors.conf" ''
          general {
            col.active_border = rgb({{colors.primary.default.hex_stripped}})
            col.inactive_border = rgb({{colors.outline.default.hex_stripped}})
          }
        '';
      };
    };
  };
}
