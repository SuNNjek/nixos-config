{ lib, ... }:
let
  toWindowRule = {
    matches,
    props,
  }: {
    window-rule = {
      _children = (lib.map (m: { match._props = m; }) matches) ++ [props];
    };
  };
in
{
  den.aspects.niri.provides.rules = {
    homeManager.programs.niri.config =
      let
        rules = lib.map toWindowRule [
          {
            matches = [
              { app-id = "firefox$"; title = "^Picture-in-Picture$"; }
              { app-id = "firefox$"; title = "^Bild-im-Bild$"; }
            ];

            props = {
              open-floating = true;
            };
          }
        ];
      in
      {
        _children = rules;
      };
  };
}
