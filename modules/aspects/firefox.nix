{
  den.aspects.firefox = {
    homeManager = {
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
      };
    };
  };
}
