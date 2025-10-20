{
  programs = {
    zsh = {
      enable = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      defaultKeymap = "emacs";
    };

    starship = {
      enable = true;
      enableZshIntegration = true;      
    };
  };
}
