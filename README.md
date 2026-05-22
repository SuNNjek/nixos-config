# nixos-config

My personal NixOS config

## Usage

When setting up a new host

1. Add host config under `hosts/<system type>/`
2. Add the config to `flake.nix`
3. Commit your changes
4. Boot into the Nix installer ISO
5. Clone the repository
6. Run `install.sh -h <your hostname>`

