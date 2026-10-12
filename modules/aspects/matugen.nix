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

    getThemes =
      pkgs:
      pkgs.fetchFromGitHub {
        owner = "InioX";
        repo = "matugen-themes";
        rev = "707c7b7d3550c9c21c0a8d72186748b1d205b88b";
        hash = "sha256-nUfF1KyKK2BherOwPwai6JzsrykP/zKxiAmoi7TTlvw=";
      };

    getTemplate = pkgs: name: "${getThemes pkgs}/templates/${name}";
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
              templates.openrgb = {
                input_path = openrgbInput;
                output_path = "~/.config/matugen/openrgb.toml";
                post_hook = "${lib.getExe openrgbMatugen}";
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

      obs = {
        homeManager =
          { pkgs, ... }:
          {
            services.matugen = {
              templates.obs = {
                input_path = getTemplate pkgs "matugen.obt";
                output_path = "~/.config/obs-studio/themes/matugen.obt";
              };
            };
          };
      };

      steam = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              adwsteamgtk
            ];

            services.matugen = {
              templates.steam = {
                input_path = getTemplate pkgs "steam.css";
                output_path = "~/.config/AdwSteamGtk/custom.css";
                post_hook =  "adwaita-steam-gtk -i";
              };
            };
          };
      };
    };
  };
}
