{ lib, ... }: {
  options = with lib; {
    sunner.useCases = {
      imageEditing = {
        enable = mkEnableOption "Image editing";
      };
    };
  };
}
