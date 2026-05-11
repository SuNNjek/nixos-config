{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.sunner.useCases.development;
in
lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    nixd
    nixpkgs-lint-community

    jetbrains-toolbox
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

      nix-direnv.enable = true;
    };

    vscode.enable = true;

    nemo.actions.open-with-vscode = {
      Name = "Open with VS Code";
      Comment = "Open the selected directory with VS Code";
      Exec = "code %F";
      Icon-Name = "com.visualstudio.code";
      Selection = "none";
      Extensions = [ "dir" ];
      Quote = "double";
      Dependencies = [ "code" ];
    };
  };
}
