{ lib, ... }:
let
  getOverlaysRecursive =
    let
      removeNixSuffix = lib.removeSuffix ".nix";
      isNixFile = lib.hasSuffix ".nix";

      processDir =
        dir:
          lib.concatMapAttrs
            (name: type:
              let
                path = dir + "/${name}";
              in
              if type == "directory" then
                {
                  "${name}" = getOverlaysRecursive path;
                }
              else if type == "regular" && isNixFile name then
                {
                  "${removeNixSuffix name}" = import path;
                }
              else
                {
                  # ignore
                }
            ) (builtins.readDir dir);
    in dir: 
      let
        defaultPath = dir + "/overlay.nix";
      in
      if lib.pathExists defaultPath then
        import defaultPath
      else
        processDir dir;

  overlays = getOverlaysRecursive ./_overlays;
in {
  flake.overlays = overlays;
}
