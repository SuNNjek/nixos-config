{ pkgs, inputs, ... }: {
    imports = [
        ../shared.nix
        ./hardware-configuration.nix

        inputs.disko.nixosModules.disko
        ./disk-layout.nix
    ];

    # TODO: Add more stuff here
    networking.hostName = "nixosVm";

    environment = {
        systemPackages = with pkgs; [
            gh
        ];
    };
}
