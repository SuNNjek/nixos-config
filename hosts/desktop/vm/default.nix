{
  imports = [
    ../.
    ./hardware-configuration.nix

    ../modules/hyprland.nix
  ];

  sunner.diskLayout = {
    btrfs = {
      enable = true;
      device = "/dev/sda";
    };

    tmp.enable = true;
  };

  networking.hostName = "nixosVm";
}
