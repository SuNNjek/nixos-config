{ lib, den, ... }:
{
  # user aspect
  den.aspects.robin = {
    includes = lib.concatLists [
      # Batteries
      (with den.batteries; [
        define-user
        primary-user
        (user-shell "zsh")
        (initial-password "changeMe")
      ])

      # Aspects
      (with den.aspects; [
        dms._.greeter-user

        vesktop
        hyprland
        gpg
      ])
    ];

    homeManager =
      { ... }:
      {
        home = {
          file.".face".source = ./buizel.png;
          shell.enableZshIntegration = true;
        };

        programs = {
          starship.enable = true;

          zsh = {
            enable = true;

            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;

            defaultKeymap = "emacs";
          };

          gpg.enable = true;

          git = {
            settings = {
              user = {
                name = "Sunner";
                email = "sunnerlp@gmail.com";
              };

              alias = {
                st = "status";
                ds = "diff --staged";
                unstage = "restore --staged";
              };

              pull.rebase = true;
            };

            signing = {
              signByDefault = true;
              key = "068C46171236B7AD"; # Needs to be imported
            };
          };
        };
      };
  };
}
