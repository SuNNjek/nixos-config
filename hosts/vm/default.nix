{ pkgs, inputs, username, ... }: {
    imports = [
        ../shared.nix
        ./hardware-configuration.nix

        inputs.disko.nixosModules.disko
        ./disk-layout.nix

        inputs.home-manager.nixosModules.home-manager

        ../../modules/kde.nix
        ../../modules/home-manager.nix
    ];

    # TODO: Add more stuff here
    networking.hostName = "nixosVm";

    environment = {
        systemPackages = with pkgs; [
            gh
            vscode
        ];
    };

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    home-manager.users.${username} = import ../../users/${username};
}
