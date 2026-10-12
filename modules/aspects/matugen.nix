{ ... }:
let
  homeManagerModule =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib)
        mkIf
        mkOption
        mkEnableOption
        types
        ;

      cfg = config.services.matugen;

      tomlFormat = pkgs.formats.toml { };

      templateType =
        with types;
        submodule {
          options = {
            input_path = mkOption {
              type = oneOf [
                str
                path
              ];
              default = "/dev/null";
            };
            output_path = mkOption {
              type = oneOf [
                str
                path
              ];
              default = "/dev/null";
            };

            pre_hook = mkOption {
              type = nullOr str;
              default = null;
            };
            post_hook = mkOption {
              type = nullOr str;
              default = null;
            };
          };
        };

      configContent = {
        config = { };
        inherit (cfg) templates;
      };
    in
    {
      options = {
        services.matugen = {
          enable = mkEnableOption "matugen";
          templates = mkOption {
            type = types.attrsOf templateType;
            default = { };
          };
        };
      };

      config = mkIf cfg.enable {
        xdg.configFile."matugen/config.toml".source = lib.pipe configContent [
          (lib.filterAttrsRecursive (_k: v: v != null))
          (tomlFormat.generate "matugen.toml")
        ];
      };
    };
in
{
  den.aspects.matugen = {
    homeManager = {
      imports = [ homeManagerModule ];

      services.matugen.enable = true;
    };

    provides = {
      openrgb = {
        homeManager =
          { lib, pkgs, ... }:
          let
            openrgbMatugen = pkgs.writeShellApplication {
              name = "openrgb-matugen";

              runtimeInputs = with pkgs; [
                toml2json
                jq
                openrgb
              ];

              text = ''
                CONFIG_PATH="$HOME/.config/matugen/openrgb.toml"
                COLOR="$(toml2json "$CONFIG_PATH" | jq -r ".color")"

                openrgb -m static -c "$COLOR"
              '';
            };

            openrgbInput = pkgs.writeText "openrgb-input" ''
              color = "{{colors.source_color.default.hex_stripped}}"
            '';
          in {
            services.matugen = {
              templates = {
                openrgb = {
                  input_path = openrgbInput;
                  output_path = "~/.config/matugen/openrgb.toml";
                  post_hook = "${lib.getExe openrgbMatugen}";
                };
              };
            };

            systemd.user.services = {
              openrgb-matugen = {
                Unit = {
                  Description = "Calls OpenRGB with color from Matugen";
                  ConditionPathExists = "%h/.config/matugen/openrgb.toml";
                };
            
                Service = {
                  Type = "oneshot";
                  ExecStart = lib.getExe openrgbMatugen;
                };
              };
            };
          };
      };
    };
  };
}
