{
  den.default.nixos = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };

  den.default.homeManager = { pkgs, ... }: {
    home = {
      packages = [ pkgs.htop ];
    };
  };
}
