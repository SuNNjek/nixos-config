{ lib, den, ... }:
let 
  stateVersion = "25.05";
in 
{
  # enable hm by default
  den.schema.user = {
    classes = lib.mkDefault [ "homeManager" ];
    includes = [ den.batteries.mutual-provider ];
  };

  den.default.includes =
    (with den.batteries; [ hostname host-aspects ]) ++
    (with den.aspects; [ overlays ]);

  den.default.nixos = {
    system = { inherit stateVersion; };

    hardware.enableRedistributableFirmware = true;
  };

  den.default.homeManager.home = { inherit stateVersion; };
}
