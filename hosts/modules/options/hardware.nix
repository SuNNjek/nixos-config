{ lib, ... }:
with lib;
{
  options = {
    sunner.hardware = {
      hasOpticalDrive = mkOption {
        type = types.bool;
        description = "Whether or not an optical drive is available";
        default = false;
      };
    };
  };
}
