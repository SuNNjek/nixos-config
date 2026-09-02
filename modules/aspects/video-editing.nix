{ self, inputs, ... }: {
  flake-file.inputs = {
    rotate-plugin = {
      url = "github:SuNNjek/rotate-plugin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.video-editing = {
    nixos = { pkgs, ... }: {
      nixpkgs.overlays = [self.overlays.ffms2];

      environment.systemPackages = with pkgs; [
        avisynthplus
        ffms

        inputs.rotate-plugin.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          kdePackages.kdenlive
          ffmpeg-full
          handbrake
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
      in
      {
        # Equivalent (for now?)
        streaming.includes = [ obs ];
        recording.includes = [ obs ];
      };
  };
}
