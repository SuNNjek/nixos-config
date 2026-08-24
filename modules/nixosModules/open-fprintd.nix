{ self, ... }:
{
  flake.nixosModules.open-fprintd =
    { config, lib, pkgs, ... }:
    let
      cfg = config.services.open-fprintd;
      system = pkgs.stdenv.hostPlatform.system;

      yamlFormat = pkgs.formats.yaml {};
    in {
      options = {
        services.open-fprintd = {
          enable = lib.mkEnableOption "open-fprintd";
          package = lib.mkPackageOption pkgs "open-fprintd" {};
          fprintdPackage = lib.mkPackageOption pkgs "fprintd" {};

          pamServices = lib.mkOption {
            type = with lib.types; listOf str;
            default = [ "login" ];
          };

          validity = {
            enable = lib.mkEnableOption "python-validity";
            package = lib.mkPackageOption self.packages.${system} "python-validity" {};

            settings = lib.mkOption {
              type = yamlFormat.type;
              default = {
                user_to_sid = {};
              };
            };
          };
        };
      };

      config = lib.mkIf cfg.enable (lib.mkMerge [
        {
          environment.systemPackages = [ cfg.fprintdPackage ];
          systemd.packages = [ cfg.package ];
          services.dbus.packages = [ cfg.package ];

          services.fprintd.enable = false;

          security.pam.services =
            cfg.pamServices
            |> lib.map
              (service: {
                ${service}.fprintAuth = true;
              })
            |> lib.mkMerge;
        }

        (lib.mkIf cfg.validity.enable {
          environment.systemPackages = [ cfg.validity.package ];
          services.dbus.packages = [ cfg.validity.package ];

          systemd.services.python3-validity = {
            description = "python3-validity driver dbus service";
            after = [ "open-fprintd.service" ];

            serviceConfig = {
              Type = "simple";
              ExecStart = "${cfg.validity.package}/bin/dbus-service";
              Restart = "no";
            };

            wantedBy = [ "multi-user.target" ];
          };

          environment.etc."python-validity/dbus-service.yaml" = {
            source = yamlFormat.generate "python-validity.yaml" cfg.validity.settings;
          };
        })
      ]);
    };
}
