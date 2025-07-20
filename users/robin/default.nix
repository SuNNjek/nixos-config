{ lib, pkgs, ... }: {
    imports = [
      ../shared.nix  
    ];

    home = {
        packages = with pkgs; [
            neofetch
        ];

        stateVersion = "25.05";
    };

    programs = {
        git = {
            enable = true;
            userName = "Sunner";
            userEmail = "sunnerlp@gmail.com";
        };
    };
}