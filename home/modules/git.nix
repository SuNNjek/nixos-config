{
  programs = {
    git = {
      enable = true;

      aliases = {
        st = "status";
        ds = "diff --staged";
      };

      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };

    gh.enable = true;
  };
}
