{ den, ... }:
{
  # user aspect
  den.aspects.robin = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")

      (den.batteries.initial-password "changeMe")

      den.aspects.dms._.greeter-user

      den.aspects.vesktop
      den.aspects.hyprland
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
