{
  lib,
  config,
  osConfig,
  inputs,
  pkgs,
  ...
}: with lib; let
  inherit (lib.meta) getExe;

  kitty = getExe pkgs.kitty;

  cfg = config.sunner.hyprland;
in {
  imports = [
    inputs.hypotd.homeManagerModules.default

    ./binds.nix
    ./rules.nix

    ./dms.nix
  ];

  options = {
    sunner.hyprland = {
      enable = mkEnableOption "Hyprland";
    };
  };

  config = {
    wayland.windowManager.hyprland = mkIf cfg.enable {
      enable = true;
      systemd.variables = [ "--all" ];

      settings = {
        "$terminal" = kitty;

        general = {
          gaps_out = 8;
          gaps_in = 4;
          resize_on_border = true;
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

        source = [
          "~/.config/hypr/colors.conf"
        ];
      };

      plugins = with pkgs; [
        csd-titlebar-move
      ];
    };

    services = {
      hyprpolkitagent.enable = true;

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
        customCommand = "dms ipc call wallpaper set {{.Path}}";
      };
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      # xdg-desktop-portal-hyprland doesn't implement a file picker.
      # According to the docs, you should install the GTK one as well.
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
