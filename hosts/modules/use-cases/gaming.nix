{ inputs, lib, config, pkgs, ... }: let
  cfg = config.sunner.useCases.gaming;
in {
  imports = [
    inputs.nixos-rocksmith.nixosModules.default
  ];

  options = with lib; {
    sunner.useCases.gaming = {
      enable = mkEnableOption "Gaming";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      protonup-rs
    ];

    users.users = let
      users = lib.attrNames config.sunner.users;
    in lib.genAttrs users (username: {
      extraGroups = [ "audio" "rtkit" ];
    });

    programs = {
      gamescope.enable = true;
      gamemode.enable = true;

      steam = {
        enable = true;
        protontricks.enable = true;
        rocksmithPatch.enable = true;

        extraCompatPackages = with pkgs; [
          steamtinkerlaunch
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
