{ pkgs, inputs, username, ... }: {
    imports = [
        ../shared.nix
        ./hardware-configuration.nix

        inputs.disko.nixosModules.disko
        ./disk-layout.nix

        ../../modules/kde.nix
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
}
