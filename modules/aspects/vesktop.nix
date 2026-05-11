{ lib, ... }: {
  den.aspects.vesktop = {
    homeManager =
      { pkgs, ... }:
      let
        vesktopAutostart = pkgs.makeDesktopItem {
          name = "vesktop";
          desktopName = "Vesktop";
          # Vesktop starts too quickly, so delay it by 5 seconds
          exec = "${lib.getExe pkgs.bash} -c \"sleep 5 && ${lib.getExe pkgs.vesktop} --enable-speech-dispatcher --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true --start-minimized\"";
        };
      in
      {
        programs.vesktop.enable = true;
        xdg.autostart.entries = [
          "${vesktopAutostart}/share/applications/vesktop.desktop"
        ];
      };
  };
}
