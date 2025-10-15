{ username, lib, config, pkgs, ... }:
let
  # Higher priorty than mkDefault, but lower than mkForce
  mkForceSoft = lib.mkOverride 900;
in {
  imports = [
    ../.

    ./modules/pipewire.nix
    ./modules/flatpak.nix
    ./modules/stylix.nix
  ];

  boot = {
    # Use Zen kernel on desktop. Can still be forced with lib.mkForce if other kernel is required/desired.
    kernelPackages = mkForceSoft pkgs.linuxPackages_zen;
    kernelModules = [ "ntsync" ];


    plymouth.enable = true;
  };

  stylix.targets.plymouth.logoAnimated = false;

  # Use NetworkManager on desktop
  networking.networkmanager.enable = true;
  
  # Create user with sudo rights
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = "changeMe";
    extraGroups = [ "wheel" ];
  };

  # Manage user with home manager
  home-manager.users.${username} = import ../../home/users/${username};

  # Add user to trusted Nix users
  nix.settings.trusted-users = [ username ];

  # User is allowed to do sudo things without inputting a password on desktop.
  # You might think that's insecure, but you're probably not as lazy as me :P
  # It's fine on a desktop tbh, I don't have super important data there, delete my video games if you like, idc
  security.sudo.extraRules = [
    {
      users = [ username ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Set the flake location for nh for rebuilding the system.
  # ofc you gotta clone it to that location yourself, this can't done here ^^
  programs.nh.flake = "/home/${username}/git/nixos-config";

  services = {
    # Set X server keyboard layout
    xserver = {
      xkb.layout = "de";
    };

    accounts-daemon.enable = true;

    blueman.enable = config.hardware.bluetooth.enable;
  };
}
