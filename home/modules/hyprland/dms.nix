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


  gtk = {
    enable = true;

    theme = {
      package = pkgs.colloid-gtk-theme;
      name = "Colloid";
    };

    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid";
    };
  };

  qt = {
    enable = true;
  };
}
