{ ... }:
{
  den.aspects.hyprland.provides.grimblast = {
    homeManager =
      { config, lib, pkgs, ... }:
      {
        home = {
          packages = [ pkgs.grimblast ];

          activation = {
            createScreenshotsDirectory = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
              mkdir -p ${config.xdg.userDirs.pictures}/Screenshots
            '';
          };
        };

        systemd.user.sessionVariables = {
          GRIMBLAST_EDITOR = "satty --filename";
        };

        programs.satty = {
          enable = true;

          settings = {
            general = {
              output-filename = "${config.xdg.userDirs.pictures}/Screenshots/%F_%T.png";
            };
          };
        };
      };
  };
}
