{ lib, pkgs, ... }: {
  imports = [
    ./pipewire.nix
  ];

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  environment = {
    variables = {
      # Use Wayland in Chromium/Electron based applications
      NIXOS_OZONE_WL = "1";
    };
  };
}
