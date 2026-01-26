{ config, lib, ... }:
with lib;
let
  cfg = config.sunner.hardware;
in
{
  boot.kernelModules = optional cfg.hasOpticalDrive "sg";

  services = {
    linux-enable-ir-emitter.enable = cfg.hasIrCamera;

    howdy = {
      enable = cfg.hasIrCamera;
      control = "sufficient";
    };
  };
}
