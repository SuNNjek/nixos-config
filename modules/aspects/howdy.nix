{
  den.aspects.howdy = {
    nixos = {
      services = {
        linux-enable-ir-emitter.enable = true;

        howdy = {
          enable = true;
          control = "sufficient";
        };
      };
    };
  };
}
