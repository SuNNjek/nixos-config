{
  den.aspects.image-editing = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          gimp3-with-plugins
          imagemagick
        ];
      };
  };
}
