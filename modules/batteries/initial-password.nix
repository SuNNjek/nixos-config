{ ... }:
let
  description = ''
    Sets the initial password for the current user.
  '';

  initialPassword = password: {
    inherit description;
    includes = [
      ({ user, host, ... }: {
        nixos.users.users.${user.userName} = {
          initialPassword = password;
        };
      })
    ];
  };

in {
  den.batteries.initial-password = initialPassword;
}
