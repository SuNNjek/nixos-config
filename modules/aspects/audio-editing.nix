{
  den.aspects.audio-editing = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          audacity
        ];
      };

    provides = {
      recording = {
        nixos = {
          services.pipewire.jack.enable = true;
        };

        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              ardour
            ];
          };
      };
    };
  };
}
