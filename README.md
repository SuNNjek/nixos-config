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

TODO: Look into building a custom installer ISO

## Structure

The config is structured as follows:

 - `home`: Home manager configs
   - `modules`: Configs for various applications. The applications themselves need to be enabled in the
      home manager config, but here I defined the default options.
   - `use-cases`: More configs for enabling things based on host use-case (see below)
 - `hosts`: Host configs
   - `modules`: Mostly the same as for the home manager configs. Use-cases are defined here (TODO: Maybe
      move them into the root? They're a pretty central feature of my config).
 - `overlays`: Overlays for custom packages or package overrides

### Use-cases

Since I manage multiple hosts with this config that I use for different things, host configs can define
"use-cases". Some applications are installed on the hosts based on these use-cases. For example, Steam is
only added if the gaming use-case is enabled, Kdenlive only if the video-editing use-case is
enabled etc.

Check out the host configs and `use-case` directories for how they work.
