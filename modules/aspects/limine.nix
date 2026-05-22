{
  den.aspects.limine = {
    nixos =
      { pkgs, ... }:
      {
        boot.loader.limine = {
          enable = true;

          # Should be enough and doesn't spam the boot menu
          maxGenerations = 5;

          extraConfig = "quiet: yes";
        };

        environment.systemPackages = with pkgs; [
          limine
        ];
      };
  };
}
