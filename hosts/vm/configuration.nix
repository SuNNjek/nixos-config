{ inputs, ... }: {
    imports = [
        ../shared.nix
        ./hardware-configuration.nix

        inputs.disko.nixosModules.disko
        ./disk-layout.nix
        {
            _module.args.disk = "dev/sda";
        }
    ];

    # TODO: Add more stuff here
}