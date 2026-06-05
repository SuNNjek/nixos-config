{ lib, ... }:
{
  den.aspects.niri.provides.dms = {
    nixos = {
      programs.dank-material-shell.greeter.compositor = {
        name = lib.mkForce "niri";
        customConfig = lib.mkForce ''
          input {
            touchpad {
              tap
              natural-scroll
            }
          }

          hotkey-overlay {
            skip-at-startup
          }

          cursor {
            xcursor-theme "Bibata-Modern-Ice"
            xcursor-size 24
          }

          output "Dell Inc. DELL P2225H DNWN504" {
            transform "270"
          }
        '';
      };
    };
  };
}
