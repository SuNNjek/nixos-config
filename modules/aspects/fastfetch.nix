{ lib, ... }:
{
  den.aspects.fastfetch = {
    homeManager = { pkgs, ... }: {
      programs.fastfetch = {
        enable = true;

        settings = {
          logo = {
            type = "command-raw";
            source = "${lib.meta.getExe pkgs.krabby} name buizel --no-title";
          };

          display = {
            separator = "  ";
          };

          modules = [
            "title"
            "separator"
            "os"
            {
              type = "kernel";
              format = "{release}";
            }
            {
              type = "packages";
              combined = true;
            }
            "separator"

            "cpu"
            {
              type = "gpu";
              format = "{vendor} {name} ({driver})";
            }
            "separator"

            "opengl"
            "vulkan"
            "separator"

            "shell"
            "wm"
            "theme"
            "icons"
            "terminal"
            "break"

            "colors"
          ];
        };
      };
    };
  };
}
