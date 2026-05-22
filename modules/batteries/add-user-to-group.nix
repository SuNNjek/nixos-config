{ ... }:
let
  description = ''
    Adds the user to the given group
  '';

  addUserToGroup = group: {
    inherit description;
    includes = [
      ({ user, host, ... }: {
        nixos.users.users.${user.userName} = {
          extraGroups = [
            group
          ];
        };
      })
    ];
  };
in
{
  den.batteries.add-user-to-group = addUserToGroup;
}
