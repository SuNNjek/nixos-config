{ inputs, den, ... }:
{
  flake-file.inputs = {
    csd-titlebar-move = {
      url = "github:SuNNjek/csd-titlebar-move";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.hyprland = {
    includes = with den.aspects.hyprland.provides; [
      settings
      binds
      rules
      grimblast
    ];

    nixos = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

    homeManager =
      { pkgs, ... }:
      let
        csd-titlebar-move =
          inputs.csd-titlebar-move.packages.${pkgs.stdenv.hostPlatform.system}.csd-titlebar-move;
      in
      {
        systemd.user.sessionVariables = {
          NIXOS_OZONE_WL = "1";
        };

        home.packages = with pkgs; [
          xrandr
        ];

        wayland.windowManager.hyprland = {
          enable = true;
          systemd.variables = [ "--all" ];

          plugins = [ csd-titlebar-move ];
        };

        xdg.portal = {
          enable = true;
          xdgOpenUsePortal = true;

          # xdg-desktop-portal-hyprland doesn't implement a file picker.
          # According to the docs, you should install the GTK one as well.
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };
      };
  };
}
