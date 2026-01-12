{ lib, pkgs, osConfig, ... }: {
  imports = [
    ../..
  ];

  home = {
    file.".face".source = ./buizel.png;

    shell.enableZshIntegration = true;

    packages = lib.optionals osConfig.sunner.hardware.hasOpticalDrive (
      with pkgs; [
        kdePackages.k3b
        makemkv
      ]
    );
  };

  programs.git = {
    settings = {
      user = {
        name = "Sunner";
        email = "sunnerlp@gmail.com";
      };

      pull.rebase = true;
    };

    signing = {
      signByDefault = true;
      key = "068C46171236B7AD"; # Needs to be imported
    };
  };

  programs = {
    vesktop.enable = true;
    obsidian.enable = true;

    fastfetch = {
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
}
