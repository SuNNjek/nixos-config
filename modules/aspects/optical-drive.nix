{
  den.aspects.optical-drive = {
    nixos = {
      boot.kernelModules = [ "sg" ];
    };
  };
}
