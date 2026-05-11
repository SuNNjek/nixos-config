{ den, ... }:
let
  includes = with den.aspects; [
    limine
    zram

    desktop
    hyprland
    dms

    gaming

    video-editing
    video-editing._.recording

    image-editing

    audio-editing
    audio-editing._.recording
  ];
in
{
  den.aspects.robin-pc = {
    includes = with den.aspects; [
      limine
      zram

      desktop
      hyprland
      dms

      gaming

      video-editing
      video-editing._.recording

      image-editing

      audio-editing
      audio-editing._.recording
    ];
  };
}
