{ lib, pkgs, config, ... }:
let 
  inherit (lib) mkAfter;
  inherit (lib.strings) trim concatLines;
  inherit (lib.meta) getExe;

  # Trims each line of the input string and also trims the result
  trimFormat = let
    inherit (builtins) filter split;
    removeEmptyLines = filter (line: line != [] || line == "");
    trimLines = map trim;
  in s:
    trim (
      concatLines (
        trimLines (
          removeEmptyLines (split "\n" s)
        )
      )
    );
in {
  stylix.targets.waybar = {
    font = "sansSerif";

    addCss = false;
  };

  home.packages = with pkgs; [
    # For icons
    font-awesome
  ];

  programs.waybar = {
    enable = config.sunner.hyprland.enable;
    systemd.enable = true;

    style = mkAfter (builtins.readFile ./waybar.css);

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 40;

        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-right = [
          "tray"
          "network"
          "wireplumber"
          "battery"
          "cpu"
          "memory"
          "clock"
        ];

        clock = {
          format = trimFormat ''
            {0:%H:%M}
            <span size="small" alpha="60%">{0:%x}</span>
          '';
          tooltip-format = "{:%c}";
          tooltip = true;
          justify = "center";
        };

        "custom/launcher" = {
          format = "  <span font_family=\"Font Awesome 6 Free\"></span>  ";
          tooltip = false;
          on-click = getExe pkgs.walker;
        };

        battery = {
          format = ''<span font_family="Font Awesome 6 Free">{icon}</span>  {capacity}%'';
          format-icons = [
            "" # Icon: battery-full
            "" # Icon: battery-three-quarters
            "" # Icon: battery-half
            "" # Icon: battery-quarter
            "" # Icon: battery-empty
          ];
        };

        wireplumber = {
          on-click = getExe pkgs.pavucontrol;
          format = ''<span font_family="Font Awesome 6 Free">{icon}</span>  {volume}%'';
          format-icons = ["" "" ""];
        };

        cpu = {
          format = ''<span font_family="Font Awesome 6 Free"></span>  {usage}%'';
        };

        memory = {
          format = ''<span font_family="Font Awesome 6 Free"></span>  {percentage}%  ({swapPercentage}%)'';
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };

        "hyprland/window" = {
          separate-outputs = true;
          icon = true;
          icon-size = 20;
        };
      };
    };
  };
}
