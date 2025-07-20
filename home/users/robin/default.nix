{ lib, pkgs, ... }: {
    imports = [
      ../shared.nix

      ../../modules/git.nix
    ];

    home = {
        packages = with pkgs; [
            neofetch
        ];

        stateVersion = "25.05";
    };

    programs = {
        git = {
            userName = "Sunner";
            userEmail = "sunnerlp@gmail.com";
        };
    };
}