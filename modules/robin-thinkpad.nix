{ den, ... }:
{
  den.aspects.robin-thinkpad = {
    includes = with den.aspects; [
      limine
      zram

      desktop
      hyprland
      dms

      image-editing
      audio-editing
    ];
  };
}
