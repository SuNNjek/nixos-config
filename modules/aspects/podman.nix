{ den, ... }:
{
  den.aspects.podman = {
    includes = [
      (den.batteries.add-user-to-group "podman")
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          podman-compose
        ];

        virtualisation = {
          containers.registries.settings = {
            unqualified-search-registries = [ "docker.io" ];
          };

          podman = {
            enable = true;

            dockerSocket.enable = true;
            dockerCompat = true;

            autoPrune.enable = true;
          };
        };
      };
    };
}
