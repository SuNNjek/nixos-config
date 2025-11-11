{ lib, config, pkgs, ... }: {
  options = with lib; {
    programs.grimblast = {
      enable = mkEnableOption "grimblast";
      package = mkPackageOption pkgs "grimblast" { };
      
      enableSatty = mkOption {
        type = types.bool;
        description = "Whether to use Satty for editing screenshots";
        default = true;
      };

      outputFilename = mkOption {
        type = types.str;
        description = "Output filename for Satty";
        default = "${config.xdg.userDirs.pictures}/Screenshots/%F_%T.png";
      };
    };
  };

  config = let 
    cfg = config.programs.grimblast;
  in lib.mkIf cfg.enable {
    home = {
      packages = [ cfg.package ];

      activation = lib.mkIf cfg.enableSatty {
        myActivationAction = lib.hm.dag.entryAfter ["linkGeneration"] ''
          mkdir -p "${dirOf cfg.outputFilename}"
        '';
      };
    };

    systemd.user.sessionVariables = lib.mkIf cfg.enableSatty {
      GRIMBLAST_EDITOR = "satty --filename";
    };

    programs.satty = {
      enable = cfg.enableSatty;

      settings = {
        general = {
          output-filename = cfg.outputFilename;
        };
      };
    };
  };
}
