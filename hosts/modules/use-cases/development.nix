{ lib, ... }: {
  options = with lib; {
    sunner.useCases = {
      development = {
        enable = mkEnableOption "Development";
      };
    };
  };
}
