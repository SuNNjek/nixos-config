{ lib, den, ... }:
let 
  stateVersion = "25.05";
in 
{
  # enable hm by default
  den.schema.user = {
    classes = lib.mkDefault [ "homeManager" ];
    includes = [ den.batteries.mutual-provider ];
  };

  den.default.includes =
    (with den.batteries; [ hostname host-aspects ]) ++
    (with den.aspects; [ overlays ]);

  den.default.nixos = { pkgs, ... }: {
    system = { inherit stateVersion; };

    hardware.enableRedistributableFirmware = true;

    networking = {
      # Use a firewall
      firewall.enable = true;
      nftables.enable = true;
    };

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];

    environment.systemPackages = with pkgs; [
      unzip
      p7zip
      file
      gettext
      icoutils
      wget
      lm_sensors
    ];

    programs = {
      htop.enable = true;

      vim = {
        enable = true;
        package = pkgs.vim-full;
        defaultEditor = true;
      };

      nh = {
        enable = true;

        clean = {
          enable = true;
          extraArgs = "--keep 5 --keep-since 3d";
        };
      };
    };
  };

  den.default.homeManager.home = { inherit stateVersion; };
}
