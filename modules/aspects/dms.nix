{ inputs, ... }:
{
  flake-file.inputs = {
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    dsearch = {
      url = "github:AvengeMedia/danksearch/v0.2.0";
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
        imports = [
          inputs.dms.nixosModules.greeter
        ];

        environment.sessionVariables = {
          XDG_DATA_DIRS = [ "${cursorCfg.package}/share" ];
          XCURSOR_PATH = [ "${cursorCfg.package}/share/icons" ];
        };

        programs.dank-material-shell.greeter = {
          enable = true;

          compositor = {
            name = "hyprland";
            customConfig = ''
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
      in
      {
        imports = [
          inputs.dms.homeModules.dank-material-shell
          inputs.dsearch.homeModules.default
        ];

        home = {
          packages = with pkgs; [
            pywalfox-native
          ];

          pointerCursor = cursorTheme;
        };

        programs = {
          dank-material-shell = {
            enable = true;
            systemd.enable = true;
          };

          dsearch = {
            enable = true;

            config = {
              indexPaths = [
                {
                  path = config.xdg.userDirs.pictures;
                  max_depth = 0;
                  extract_exif = true;
                }
              ];
            };
          };

          kitty.extraConfig = ''
            include dank-theme.conf
            include dank-tabs.conf
          '';
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

          gtk2 = { enable = true; inherit theme cursorTheme iconTheme; };
          gtk3 = { enable = true; inherit extraCss theme cursorTheme iconTheme; };
          gtk4 = { enable = true; inherit extraCss theme cursorTheme iconTheme; };
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

        programs.firefox.nativeMessagingHosts = with pkgs; [ pywalfox ];
        xdg.cacheFile."wal/colors.json".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/dank-pywalfox.json";
      };

    provides = {
      greeter-user = {
        includes = [
          ({ user, host, ... }: {
            nixos.programs.dank-material-shell.greeter.configHome = "/home/${user.userName}";
          })
        ];
      };
    };
  };
}
