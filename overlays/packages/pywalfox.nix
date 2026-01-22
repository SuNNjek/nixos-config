{
  stdenv,
  pywalfox-native,
}: stdenv.mkDerivation {
  inherit (pywalfox-native) version;

  pname = "pywalfox";
  dontUnpack = true;

  nativeBuildInputs = [
    pywalfox-native
  ];

  configurePhase = ''
    export HOME=$TMP
  '';

  buildPhase = ''
    pywalfox install
  '';

  installPhase = ''
    mkdir -p $out/lib/mozilla/native-messaging-hosts
    cp $TMP/.mozilla/native-messaging-hosts/pywalfox.json $out/lib/mozilla/native-messaging-hosts/pywalfox.json
  '';
}
