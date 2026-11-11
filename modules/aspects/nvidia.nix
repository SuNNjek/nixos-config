{ inputs, den, ... }:
{
  den.aspects.nvidia = {
    includes = [
      (den.batteries.unfree [
        "nvidia-x11"
        "nvidia-settings"
      ])
    ];

    nixos = { ... }: {
      imports = with inputs.nixos-hardware.nixosModules; [
        common-gpu-nvidia-nonprime
      ];

      boot.kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_drm"
      ];

      hardware.nvidia = {
        open = true;
        nvidiaSettings = true;
      };
    };
  };
}
