{
  lib,

  writeShellApplication,
  symlinkJoin,
  makeDesktopItem,

  wget,
  umu-launcher,
  proton-ge-bin,

  ...
}: let
  script = writeShellApplication {
    name = "ubisoft-connect-wrapper";

    runtimeInputs = [
      wget
      umu-launcher
    ];

    runtimeEnv = {
      SETUP_URL = "https://ubistatic3-a.akamaihd.net/orbit/launcher_installer/UbisoftConnectInstaller.exe";
      SETUP_DL_LOCATION = "/tmp/UbisoftConnectInstaller.exe";
      LAUNCHER_PATH = "/drive_c/Program Files (x86)/Ubisoft/Ubisoft Game Launcher/UbisoftConnect.exe";

      PROTONPATH = "${proton-ge-bin.steamcompattool}/";
      PROTON_VERBS = "waitforexitandrun";

      PROTON_ENABLE_WOW64 = "1";
    };

    text = ''
      export WINEPREFIX=$HOME/Games/UbisoftConnect
      mkdir -p "$WINEPREFIX"

      LAUNCHER="''${WINEPREFIX}''${LAUNCHER_PATH}"

      if [ ! -e "$LAUNCHER" ]; then
        wget -O "$SETUP_DL_LOCATION" "$SETUP_URL"
        umu-run "$SETUP_DL_LOCATION"
      fi

      umu-run "$LAUNCHER" "$@"
    '';
  };

  desktopIcon = makeDesktopItem {
    name = "ubisoft-connect";
    exec = "${lib.getExe script} %U";
    icon = "ubisoft-connect";
    desktopName = "Ubisoft Connect";
    comment = "Ubisoft Connect";
    categories = ["Game"];
  };
in symlinkJoin {
  name = "ubisoft-connect";
  paths = [
    script
    desktopIcon
  ];

  postBuild = ''
    mkdir -p "$out/share/icons/hicolor/256x256/apps"
    ln -s ${./icon.png} "$out/share/icons/hicolor/256x256/apps/ubisoft-connect.png"
  '';
}
