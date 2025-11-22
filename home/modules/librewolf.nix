{
  programs.librewolf = {
    settings = {
      # Enable WebGL
      "webgl.disabled" = false;
      
      # Enable Firefox sync
      "identity.fxaccounts.enabled" = true;

      # Don't clear history/downloads on shutdown
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;

      # Enable autoscroll instead of pasting with middle mouse
      "general.autoScroll" = true;
      "middlemouse.paste" = false;

      # Force stricter autoplay policy
      "media.autoplay.blocking_policy" = 2;
    };
  };
}
