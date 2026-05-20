{
  den.quirks.niriConfig = {
    description = "Niri configuration";
  };

  den.aspects.niri = {
    nixos = {
      programs.niri.enable = true;
    };

    homeManager = { lib, pkgs, niriConfig, ... }: {
      xdg.configFile."niri/config.kdl" =
        let
          generator = lib.hm.generators.toKDL { };
          settings = lib.mergeAttrsList niriConfig;
          text = generator settings;
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

    niriConfig = {
      input = {
        keyboard = {
          # For now...
          layout = "de";
        };
      };
    };
  };
}
