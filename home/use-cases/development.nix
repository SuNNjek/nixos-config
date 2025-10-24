{ lib, osConfig, pkgs, ... }: let 
  cfg = osConfig.sunner.host.useCases.development;
in lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    nixd
    nixpkgs-lint-community
  ];

  programs = {
    git = {
      enable = true;

      settings = {
        alias = {
          st = "status";
          ds = "diff --staged";
        };

        init = {
          defaultBranch = "main";
        };
      };
    };

    gh.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;

      nix-direnv.enable = true;
    };

    vscode.enable = true;
  };
}
