{
  den.aspects.video-editing = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          kdePackages.kdenlive
          ffmpeg-full
          ccextractor
        ];
      };

    provides =
      let
        obs = {
          homeManager =
            { osConfig, pkgs, ... }:
            {
              programs.obs-studio = {
                enable = true;

                package = pkgs.obs-studio.override {
                  cudaSupport = osConfig.hardware.nvidia.enabled;
                };
              };
            };
        };
      in {
        # Equivalent (for now?)
        streaming.includes = [ obs ];
        recording.includes = [ obs ];
      };
  };
}
