{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.vesktop;
in
{
  options = {
    programs.vesktop = {
      autostart = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to automatically start Vesktop";
      };
    };
  };

  config = mkIf (cfg.enable && cfg.autostart) {
    xdg.autostart.entries =
      let
        vesktopAutostart = pkgs.makeDesktopItem {
          name = "vesktop";
          desktopName = "Vesktop";
          # Vesktop starts too quickly, so delay it by 5 seconds
          exec = "${getExe pkgs.bash} -c \"sleep 5 && ${getExe cfg.package} --enable-speech-dispatcher --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true --start-minimized\"";
        };
      in
      [
        "${vesktopAutostart}/share/applications/vesktop.desktop"
      ];
  };
}
