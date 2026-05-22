# Custom home manager module until https://github.com/nix-community/home-manager/pull/8700 is merged
{ config, pkgs, lib, ... }:
let
  cfg = config.programs.niri;
in
{
  options = {
    programs.niri = {
      enable = lib.mkEnableOption "niri";

      config = lib.mkOption {
        description = "Niri config";
        type =
          with lib.types;
          let
            valueType =
              nullOr (oneOf [
                bool
                int
                float
                str
                (attrsOf valueType)
                (listOf valueType)
              ])
              // {
                description = "KDL value";
              };
          in
          attrsOf valueType;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      niri
      xwayland-satellite
    ];

    systemd.user.packages = with pkgs; [
      niri
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      configPackages = [ pkgs.niri ];
    };

    xdg.configFile."niri/config.kdl" =
      let
        generator = lib.hm.generators.toKDL { };
        text = generator cfg.config;
      in
      {
        source = pkgs.writeTextFile {
          name = "niri-config.kdl";
          inherit text;
          checkPhase = ''
            ${lib.getExe pkgs.niri} validate --config "$target"
        '';
        };
      };
  };
}
