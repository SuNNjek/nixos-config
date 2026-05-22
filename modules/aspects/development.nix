{ den, ... }:
let

in
{
  den.aspects.development = {
    includes = [
      (den.batteries.add-user-to-group "podman")

      (den.batteries.unfree [ "jetbrains-toolbox" "vscode" ])
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          podman-compose
        ];

        virtualisation = {
          containers.registries.search = [
            "docker.io"
          ];

          podman = {
            enable = true;

            dockerSocket.enable = true;
            dockerCompat = true;

            autoPrune.enable = true;
          };
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nixd
          nixpkgs-lint-community

          jetbrains-toolbox
        ];

        programs = {
          git = {
            enable = true;

            settings = {
              init.defaultBranch = "main";
            };
          };

          gh.enable = true;

          direnv = {
            enable = true;
            nix-direnv.enable = true;
          };

          vscode.enable = true;
        };
      };

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
