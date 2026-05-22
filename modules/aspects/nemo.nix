{ lib, ... }: {
  den.quirks.nemo = {
    description = "Nemo configuration";
  };

  den.aspects.nemo = {
    homeManager =
      { nemo, pkgs, ... }:
      let
        nemoPkg = pkgs.nemo-with-extensions;
      in
      {
        home.packages = [ nemoPkg ];
        dbus.packages = [ nemoPkg ];

        xdg = {
          mimeApps.defaultApplicationPackages = [ nemoPkg ];

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
