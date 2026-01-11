{
  fetchFromGitHub,
  lib,

  hyprland,
  pkg-config,

  rev,
  sha256,
    ...
}: hyprland.stdenv.mkDerivation {
  pname = "csd-titlebar-move";
  version = rev;

  src = fetchFromGitHub {
    inherit rev sha256;

    owner = "khalid151";
    repo = "csd-titlebar-move";
  };

  patches = [
    ./patches/remove-success-message.patch
    ./patches/fix-0_53.patch
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    hyprland.dev
  ] ++ hyprland.buildInputs;

  installPhase = ''
    mkdir -p $out/lib/
    cp csd-titlebar-move.so $out/lib/libcsd-titlebar-move.so
  '';

  meta = {
    description = "CSD titlebar move";
    homepage = "https://github.com/khalid151/csd-titlebar-move";
    platforms = lib.platforms.linux;
  };
}

