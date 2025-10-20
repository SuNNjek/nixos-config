{ lib, config, pkgs, ... }: let
  cfg = config.sunner.flatpak;
in {
  services.flatpak.enable = cfg.enable;

  # TODO: Move to somewhere else, it's only related to the Steam Flatpak, not Flatpak in general
  environment.systemPackages = with pkgs;
    lib.optional cfg.enable steam-devices-udev-rules;

  systemd.services.flatpak-repo = {
    enable = cfg.enable;
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  systemd.user.services.flatpak-repo = {
    enable = cfg.enable;
    wantedBy = [ "default.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
