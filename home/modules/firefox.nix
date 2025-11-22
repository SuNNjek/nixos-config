{
  programs.firefox = {
    policies = {
      DisableTelemetry = true;
      GenerativeAI = {
        Enabled = false;
        Locked = true;
      };
    };
  };
}
