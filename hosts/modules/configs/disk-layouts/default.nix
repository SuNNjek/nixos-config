{ inputs, ... }:{
  imports = [
    inputs.disko.nixosModules.disko

    ./btrfs.nix
    ./tmp.nix
  ];
}
