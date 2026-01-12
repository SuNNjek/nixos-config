{ config, lib, ... }:
with lib;
let
  cfg = config.sunner.hardware;
in {
  boot.kernelModules = optional cfg.hasOpticalDrive "sg";
}
