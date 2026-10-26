{ den, ... }:
let
  open-fprintd = {
    includes = [ den.aspects.fprintd ];

    nixos =
      { pkgs, ... }:
      {
        services.dbus.packages = [ pkgs.open-fprintd ];
        systemd.packages = [ pkgs.open-fprintd ];
      };
  };

  validity = {
    includes = [ open-fprintd ];

    nixos =
      { pkgs, ... }:
      let
        package = pkgs.python-validity;

        yamlFormat = pkgs.formats.yaml { };
        settings = {
          user_to_sid = { };
        };
      in
      {
        environment.systemPackages = [ package ];
        services.dbus.packages = [ package ];

        systemd.services.python3-validity = {
          description = "python3-validity driver dbus service";
          after = [ "open-fprintd.service" ];
          requires = [ "open-fprintd.service" ];

          serviceConfig = {
            Type = "simple";
            ExecStart = "${package}/bin/dbus-service";
            Restart = "no";
          };

          wantedBy = [ "multi-user.target" ];
        };

        environment.etc."python-validity/dbus-service.yaml" = {
          source = yamlFormat.generate "python-validity.yaml" settings;
        };
      };
  };
in
{
  den.aspects.fprintd = {
    nixos =
      { ... }:
      {
        services.fprintd.enable = true;
      };

    provides = {
      inherit validity;
    };
  };
}
