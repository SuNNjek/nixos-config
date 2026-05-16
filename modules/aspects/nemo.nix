{ lib, ... }: {
  den.quirks.nemo = {
    description = "Nemo configuration";
  };

  den.aspects.nemo = {
    homeManager = { nemo, pkgs, ... }: {
      home.packages = [ pkgs.nemo ];
      dbus.packages = [ pkgs.nemo ];

      xdg = {
        mimeApps.defaultApplicationPackages = [ pkgs.nemo ];

        dataFile =
          let
            nemoCfg = (lib.mergeAttrsList nemo);

            iniFormat = pkgs.formats.ini {
              listToValue = atoms: atoms |> lib.map (atom: "${atom};") |> lib.concatStrings;
            };

            mapAction = (
              name: action: {
                name = "nemo/actions/${name}.nemo_action";
                value = {
                  source = iniFormat.generate "${name}.nemo_action" {
                    "Nemo Action" = action;
                  };
                };
              }
            );
          in
          lib.mkIf (nemoCfg ? actions) (lib.mapAttrs' mapAction nemoCfg.actions);
      };
    };
  };
}
