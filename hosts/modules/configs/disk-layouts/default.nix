{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko

    ./btrfs.nix
  ];
}
