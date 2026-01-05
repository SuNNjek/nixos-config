{ lib, ... }: {
  options = with lib; {
    sunner.useCases = {
      videoEditing = {
        enable = mkEnableOption "Video editing";
      };
    };
  };
}
