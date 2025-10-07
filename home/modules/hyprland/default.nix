{
  lib,
  config,
  osConfig,
  inputs,
  pkgs,
  ...
}: with lib; let
  cfg = config.sunner.hyprland;
in {
  imports = [
    inputs.hypotd.homeManagerModules.default

    ./binds.nix
    ./rules.nix

    ./walker
    ./hyprlock.nix
    ./waybar.nix
    ./mako.nix
    ./wlogout.nix
  ];

  options = {
    sunner.hyprland = {
      enable = mkEnableOption "Hyprland";
    };
  };

  config = {
    wayland.windowManager.hyprland = mkIf cfg.enable {
      enable = true;

      settings = {
        "$terminal" = "kitty";

        general = {
          gaps_out = 8;
          gaps_in = 4;
        };

        input = {
          kb_layout = "de";
          # Focus window when clicking on it, not when hovering over it
          follow_mouse = 2;

          touchpad = {
            natural_scroll = true;
          };
        };

        decoration = {
          rounding = 8;

          blur = {
            passes = 2;
          };
        };

        monitor = [
          "desc:Dell Inc. DELL U2724DE 6QZ59P3,highres,0x0,1"
          "desc:Dell Inc. DELL P2225H DNWN504,highres,auto-right,1,transform,3"
          ",highres,auto,1"
        ];

        render = {
          direct_scanout = 2;
        };

        misc = {
          # Begone, anime girl
          disable_hyprland_logo = true;
        };

        # Set environment variables on NVIDIA system
        env = optionals osConfig.hardware.nvidia.enabled [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "NVD_BACKEND,direct"
        ];
      };

      plugins = with pkgs; [
        csd-titlebar-move
      ];
    };

    stylix.targets.hyprpaper.enable = mkForce false;
    services = {
      hyprpaper = {
        enable = true;

        settings = {
          ipc = "on";
        };
      };

      hypridle = {
        enable = true;

        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };
        
          listener = [
            {
              timeout = 10 * 60;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 15 * 60;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 30;
              on-timeout = "pidof hyprlock && hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };

      hyprpolkitagent.enable = true;

      # Update this when hyprsunset 0.3 hits Nix stable
      gammastep = {
        enable = true;
        provider = "geoclue2";
      };

      udiskie.enable = true;
    };

    programs.hypotd = {
      enable = true;

      config = {
        provider = "bing";
      };
    };

    home.packages = with pkgs; [
      # For screenshots
      grimblast
      # For waybar icons
      font-awesome
      # For playback control
      playerctl
    ];

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      # xdg-desktop-portal-hyprland doesn't implement a file picker.
      # According to the docs, you should install the GTK one as well.
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
