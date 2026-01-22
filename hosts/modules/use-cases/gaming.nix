{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.sunner.useCases.gaming;
in
{
  options = with lib; {
    sunner.useCases.gaming = {
      enable = mkEnableOption "Gaming";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      protonup-rs
    ];

    programs = {
      gamescope.enable = true;
      gamemode.enable = true;

      steam = {
        enable = true;
        protontricks.enable = true;

        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];

        # Open ports for some functionality in the firewall
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
    };

    services.udev.packages = with pkgs; [
      steam-devices-udev-rules
    ];
  };
}
