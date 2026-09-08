{
  den.aspects.firefox = {
    homeManager = { pkgs, ... }: {
      programs.firefox = {
        enable = true;

        policies = {
          DisableTelemetry = true;
          GenerativeAI = {
            Enabled = false;
            Locked = true;
          };

          FirefoxHome = {
            SponsoredTopSites = false;
            SponsoredPocket = false;
            SponsoredStories = false;
          };
        };

        nativeMessagingHosts = with pkgs; [ pywalfox ];
      };

      xdg.mimeApps.defaultApplicationPackages = [
        pkgs.firefox
      ];
    };
  };
}
