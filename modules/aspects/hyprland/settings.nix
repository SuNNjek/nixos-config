{ lib, ... }:
{
  den.aspects.hyprland.provides.settings = {
    homeManager =
      { osConfig, ... }:
      {
      wayland.windowManager.hyprland = {
        settings = {
          "$terminal" = "kitty";
          "$browser" = "firefox";

          general = {
            gaps_out = 8;
            gaps_in = 4;
            resize_on_border = true;

            snap = {
              enabled = true;
              respect_gaps = true;
            };
          };

          input = {
            kb_layout = "de";
            # Focus window when clicking on it, not when hovering over it
            follow_mouse = 2;

            touchpad = {
              natural_scroll = true;
            };
          };

          cursor = {
            no_warps = true;
          };

          decoration = {
            rounding = 8;

            blur = {
              passes = 2;
              popups = true;

              noise = 0.02;
              contrast = 1.1;
              vibrancy = 0.2;
              vibrancy_darkness = 0.3;
            };
          };

          group = {
            "col.border_active" = "0x60000000";
            "col.border_inactive" = "0x80000000";
              
            groupbar = {
              height = 28;
              font_size = 12;
              rounding = 8;
              gradient_rounding = 8;
              gradients = true;
              blur = true;
              "col.active" = "0x60000000";
              "col.inactive" = "0x80000000";
            };
          };

          monitor = [
            ",highres,auto,1"
          ];

          render = {
            direct_scanout = 2;
          };

          ecosystem = {
            no_donation_nag = true;
          };

          misc = {
            # Begone, anime girl
            disable_hyprland_logo = true;

            focus_on_activate = true;
          };

          animation = [
            "windows, 1, 3, default, popin 50%"
            "fade, 1, 3, default"
            "workspaces, 1, 5, default"
            "border, 1, 3, default"
          ];

          # Set environment variables on NVIDIA system
          env = lib.optionals osConfig.hardware.nvidia.enabled [
            "LIBVA_DRIVER_NAME,nvidia"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            "NVD_BACKEND,direct"
          ];
        };
      };
    };
  };
}
