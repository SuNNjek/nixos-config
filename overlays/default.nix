{
  nixpkgs.overlays = [
    (
      final: prev:
      prev.lib.packagesFromDirectoryRecursive {
        inherit (prev) callPackage;
        directory = ./packages;
      }
    )
  ];
}
