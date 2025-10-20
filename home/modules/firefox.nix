{ config, ... }: let
  username = config.home.username;
in {
  programs.firefox = {
    enable = true;

    profiles = {
      ${username} = { };
    };
  };

  stylix.targets.firefox.profileNames = [ username ];
}
