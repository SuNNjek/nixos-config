let
  buildPackages =
    pkgs:
    pkgs.lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./_packages;
    };

  packagesOverlay = (final: prev: buildPackages prev);
in
{
  flake.overlays.default = packagesOverlay;

  perSystem = { pkgs, ... }: {
    packages = buildPackages pkgs;
  };

  den.aspects.overlays = {
    nixos = {
      nixpkgs.overlays = [ packagesOverlay ];
    };
  };
}
