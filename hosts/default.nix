{ lib, pkgs, ... }:
let
  inherit (lib) mkDefault;
in {
  imports = [
    ./modules/disk-layouts
    ./modules/boot-loaders.nix
    ./modules/home-manager.nix
    ./modules/zsh.nix
    ./modules/nh.nix
  ];

  boot.loader.grub.enable = mkDefault true;

  # Use latest kernel.
  boot.kernelPackages = mkDefault pkgs.linuxPackages_latest;

  nixpkgs = {
    config = {
      # Allow unfree packages by default
      allowUnfree = mkDefault true;
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "de_DE.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1-nodeadkeys";
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment = {
    systemPackages = with pkgs; [
      wget
      lm_sensors
    ];
  };

  programs = {
    htop.enable = true;

    vim = {
      enable = true;
      defaultEditor = true;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
