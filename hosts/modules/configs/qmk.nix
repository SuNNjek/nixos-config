{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.programs.qmk;
in {
  config = mkIf cfg.enable {
    hardware.keyboard.qmk.enable = true;

    environment.systemPackages = with pkgs; [
      qmk
    ] ++ optional cfg.enableVia pkgs.via;

    services.udev.packages = with pkgs; [
      qmk-udev-rules
    ];
  };
}
