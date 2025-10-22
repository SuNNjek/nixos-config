{ inputs, config, lib, ... }: let
  cfg = config.sunner.homeManager;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";

        # Import paths for all users
        users = lib.mapAttrs (username: userConfig: lib.mkMerge [
          {
            # Set default based on username
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
            };
          }

          (import userConfig.configPath)
        ]) cfg.users;

        # TODO: Pass in username to config somehow? Or manage it all in user config?
        extraSpecialArgs = { inherit inputs; };
      };
    })

    {
      # Trust all users declared in home-manager config
      nix.settings.trusted-users = lib.attrNames cfg.users;

      users.users = lib.mapAttrs (username: userCfg: {
        inherit (userCfg) shell;

        isNormalUser = true;
        initialPassword = "changeMe";
        extraGroups = lib.optional userCfg.sudo.enable "wheel";
      }) cfg.users;
    }

    (let 
      withoutPwUsers = lib.filterAttrs
        (username: userConfig:
          userConfig.sudo.enable && userConfig.sudo.withoutPassword)
        cfg.users;
    in {
      # User is allowed to do sudo things without inputting a password on desktop.
      # You might think that's insecure, but you're probably not as lazy as me :P
      # It's fine on a desktop tbh, I don't have super important data there, delete my video games if you like, idc
      security.sudo.extraRules = [
        {
          users = lib.attrNames withoutPwUsers;
          commands = [
            {
              command = "ALL";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    })
  ];
}
