{ lib, ... }:
with lib;
{
  options = {
    # These will mostly determine what tools will be installed with Home Manager.
    # But they change depending on the host (I can't game on my Thinkpad lol) so the
    # options will be defined in the host config
    sunner.host.useCases = {
      development = {
        enable = mkEnableOption "Development";
      };

      gaming = {
        enable = mkEnableOption "Gaming";
      };

      imageEditing = {
        enable = mkEnableOption "Video editing";
      };

      videoEditing = {
        enable = mkEnableOption "Video editing";
      };

      # ... add more here later
    };
  };
}
