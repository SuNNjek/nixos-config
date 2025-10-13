{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Interesting naming there... it sure is... redundant
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;
  };
}
