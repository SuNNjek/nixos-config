{ lib, config, pkgs, ... }: {
  options = with lib; {
    programs.grimblast = {
      enable = mkEnableOption "grimblast";
      package = mkPackageOption pkgs "grimblast" { };
      
      editor = mkOption {
        type = types.nullOr types.str;
        description = "Editor to use for editing screenshots";
        default = null;
      };
    };
  };

  config = let 
    cfg = config.programs.grimblast;
  in lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    systemd.user.sessionVariables = lib.mkIf (cfg.editor != null) {
      GRIMBLAST_EDITOR = cfg.editor;
    };
  };
}
