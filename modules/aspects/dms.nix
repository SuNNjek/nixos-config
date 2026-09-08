{ lib, inputs, ... }:
{
  flake-file.inputs = {
    dcal = {
      url = "github:AvengeMedia/dankcalendar/v1.6.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.dms = {
    nixos =
      { pkgs, ... }:
      let
        cursorCfg = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
      in
      {
        environment.sessionVariables = {
          XDG_DATA_DIRS = [ "${cursorCfg.package}/share" ];
          XCURSOR_PATH = [ "${cursorCfg.package}/share/icons" ];
        };

        programs = {
          dms-shell = {
            enable = true;

            systemd = {
              enable = true;
              restartIfChanged = true;
            };
            
            enableSystemMonitoring = true;
            enableVPN = true;
            enableDynamicTheming = true;
            enableAudioWavelength = true;
            enableCalendarEvents = true;
          };

          dsearch = {
            enable = true;

            systemd = {
              enable = true;
            };
          };
        };

        services.displayManager.dms-greeter = {
          enable = true;

          compositor = {
            # Use hyprland by default
            name = lib.mkDefault "hyprland";
            customConfig = lib.mkDefault ''
              env = HYPRCURSOR_THEME,${cursorCfg.name}
              env = XCURSOR_THEME,${cursorCfg.name}

              env = HYPRCURSOR_SIZE,${toString cursorCfg.size}
              env = XCURSOR_SIZE,${toString cursorCfg.size}

              animations {
                enabled = false
              }

              input {
                kb_layout = de
              }

              misc {
                disable_hyprland_logo = true
              }

              ecosystem {
                no_update_news = true
                no_donation_nag = true
              }

              monitor = desc:Dell Inc. DELL U2724DE 6QZ59P3,highres,0x0,1
              monitor = desc:Dell Inc. DELL P2225H DNWN504,highres,auto-right,1,transform,3
              monitor = ,highres,auto,1

              workspace = 1, m:desc:Dell Inc. DELL U2724DE 6QZ59P3, default:true
            '';
          };
        };
      };

    homeManager =
      { config, pkgs, ... }:
      let
        theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
        };

        cursorTheme = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };

        iconTheme = {
          package = pkgs.vimix-icon-theme;
          name = "Vimix-dark";
        };

        extraCss = ''
          @import url("dank-colors.css");
        '';

        tomlFormat = pkgs.formats.toml { };
      in
      {
        imports = [
          inputs.dcal.homeModules.default
        ];

        home = {
          packages = with pkgs; [
            pywalfox-native

            roboto
            roboto-slab
            nerd-fonts.roboto-mono
          ];

          pointerCursor = cursorTheme;
        };

        programs = {
          dank-calendar = {
            enable = true;
            systemd.enable = true;
          };

          kitty.extraConfig = ''
            include dank-theme.conf
            include dank-tabs.conf
          '';

          niri.config =
            let
              dmsFiles = [
                "alttab"
                "binds"
                "colors"
                "cursor"
                "layout"
                "outputs"
                "windowrules"
                "wpblur"
              ];
            in
            {
              _children = lib.map (file: {
                include = {
                  _args = [ "dms/${file}.kdl" ];
                  _props.optional = true;
                };
              }) dmsFiles;
            };
        };

        services = {
          cliphist.enable = true;
        };

        wayland.windowManager.hyprland.settings.source = [
          "~/.config/hypr/dms/outputs.conf"
          "~/.config/hypr/dms/colors.conf"
          "~/.config/hypr/dms/cursor.conf"
          "~/.config/hypr/dms/layout.conf"
        ];

        gtk = {
          enable = true;
          inherit theme cursorTheme iconTheme;

          gtk3 = { inherit extraCss; };
          gtk4 = { inherit extraCss theme; };
        };

        qt = {
          enable = true;
          platformTheme = {
            name = "qtct";
            package = with pkgs; [
              libsForQt5.qt5ct
              qt6Packages.qt6ct
            ];
          };
        };

        fonts.fontconfig = {
          enable = true;

          defaultFonts = {
            sansSerif = [ "Roboto" ];
            serif = [ "Roboto Slab" ];
            monospace = [ "RobotoMono Nerd Font Mono" ];
          };
        };

        xdg.cacheFile."wal/colors.json".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/dank-pywalfox.json";

        xdg.configFile."danksearch/config.toml" = {
          source = tomlFormat.generate "dsearch.config.toml" {
            indexPaths = [
              {
                path = config.xdg.userDirs.pictures;
                max_depth = 0;
                extract_exif = true;
              }
            ];
          };
        };
      };

    provides = {
      greeter-user = {
        includes = [
          ({ user, host, ... }: {
            nixos.services.displayManager.dms-greeter.configHome = "/home/${user.userName}";
          })
        ];
      };
    };
  };
}
