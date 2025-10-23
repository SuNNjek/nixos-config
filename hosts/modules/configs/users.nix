{ inputs, config, lib, ... }: let
  cfg = config.sunner.users;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";

      # Import paths for all users
      users = lib.pipe cfg [
        (lib.filterAttrs (username: userCfg: userCfg.homeManager.enable))
        (lib.mapAttrs (username: userCfg: lib.mkMerge [
          {
            # Set default based on username
            home = {
              inherit username;
            };
          }

          (import userCfg.homeManager.configPath)
        ]))
      ];

      # TODO: Pass in username to config somehow? Or manage it all in user config?
      extraSpecialArgs = { inherit inputs; };
    };

    # Trust all users (it's fiiiine... probably)
    nix.settings.trusted-users = lib.attrNames cfg;

    users.users = lib.mapAttrs (username: userCfg: {
      inherit (userCfg) shell;

      isNormalUser = true;
      initialPassword = "changeMe";
      extraGroups = lib.optional userCfg.sudo.enable "wheel";
    }) cfg;

    # User is allowed to do sudo things without inputting a password on desktop.
    # You might think that's insecure, but you're probably not as lazy as me :P
    # It's fine on a desktop tbh, I don't have super important data there, delete my video games if you like, idc
    security.sudo.extraRules = [
      {
        users = lib.pipe cfg [
          (lib.filterAttrs (username: userCfg: userCfg.sudo.enable && userCfg.sudo.withoutPassword))
          lib.attrNames
        ];

        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
