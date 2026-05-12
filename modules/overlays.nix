{
  den.aspects.overlays = {
    nixos = {
      nixpkgs.overlays = [
        (final: prev: prev.lib.packagesFromDirectoryRecursive {
          inherit (prev) callPackage;
          directory = ./_packages;
        })
      ];
    };
  };
}
