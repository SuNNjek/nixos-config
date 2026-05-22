{ inputs, ... }:
{
  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko/v1.12.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.disko = {
    nixos = {
      imports = [
        inputs.disko.nixosModules.disko
      ];
    };
  };
}
