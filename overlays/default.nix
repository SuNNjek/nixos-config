{
  nixpkgs.overlays = [
    (import ./csd-titlebar-move)
    (import ./dms-plugins)
    (import ./klassy)
    (import ./pywalfox)

    (import ./obs-studio.nix)
  ];
}
