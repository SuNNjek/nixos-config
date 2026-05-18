{ lib, ... }:
let
  description = ''
    Allows the user to use sudo without a password
  '';

  allow-passwordless-sudo = {
    inherit description;
    includes = [
      ({ host, user, ... }: {
        nixos = {
          security.sudo.extraRules = [
            {
              users = lib.singleton user.userName;
              commands = [
                {
                  command = "ALL";
                  options = [ "NOPASSWD" ];
                }
              ];
            }
          ];
        };
      })
    ];
  };
in
{
  den.batteries = { inherit allow-passwordless-sudo; };
}
