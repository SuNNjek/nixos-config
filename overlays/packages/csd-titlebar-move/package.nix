{
  fetchFromGitHub,
  lib,

  hyprland,
  pkg-config,
}: let
  rev = "bd8ac086009245396d9172c5acd0e43cd1cfc616";
  sha256 = "sha256-ZT+1doIIPyyo/qr0qsofixY9tZpNFP4N6P4Qjr99j0Y=";
in hyprland.stdenv.mkDerivation {
  pname = "csd-titlebar-move";
  version = rev;

  src = fetchFromGitHub {
    inherit rev sha256;

    owner = "khalid151";
    repo = "csd-titlebar-move";
  };

  patches = [
    ./remove-success-message.patch
    ./fix-0_53.patch
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

