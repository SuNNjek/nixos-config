# enables `nix run .#vm`. it is very useful to have a VM
# you can edit your config and launch the VM to test stuff
# instead of having to reboot each time.
{ inputs, lib, ... }:
{
  den.default.nixos.virtualisation.vmVariant = {
    virtualisation = {
      diskSize = 10 * 1024;
      cores = 4;
      memorySize = 8192;

      qemu.options = [
        # VirtIO GPU acceleration
        "-device virtio-vga-gl"
        "-display sdl,gl=on"

        # VirtIO sound
        "-audio driver=sdl,model=virtio"
      ];
    };
  };

  perSystem =
    { pkgs, ... }:
    {
      packages = lib.mapAttrs' (
        name:
        host:
          lib.nameValuePair "${name}-vm" (pkgs.writeShellApplication {
            name = "${name}-vm";
            text =
              let
                inherit (host) config;
              in
              ''
                ${config.system.build.vm}/bin/run-${config.networking.hostName}-vm "$@"
              '';
          })
        ) inputs.self.nixosConfigurations;
    };
}
