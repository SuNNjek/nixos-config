{ lib, ... }:
{
  den.aspects.kanshi =
  let
    mainMonitor = "Dell Inc. DELL U2724DE 6QZ59P3";
    sideMonitor = "Dell Inc. DELL P2225H DNWN504";

    setPrimaryMonitorDrv =
      {
        writeShellApplication,
        wlr-randr,
        xrandr,
        jq,
      }:
      writeShellApplication {
        name = "set-primary-monitor";

        runtimeInputs = [
          wlr-randr
          xrandr
          jq
        ];

        text = ''
          DESC=$1

          # There's probably a nicer query, but I don't really know jq 
          NAME=$(wlr-randr --json | jq -r --arg desc "$DESC" '
              map(select(.description | contains($desc)))
            | .[0].name
            | select(. != null)
          ')

          if [ -z "$NAME" ]; then
            echo "no name found for monitor $DESC" >&2
            exit 1
          fi

          # Set monitor as primary monitor for XWayland
          xrandr --output "$NAME" --primary
        '';
      };

    setPrimaryMonitor = pkgs: lib.getExe <| pkgs.callPackage setPrimaryMonitorDrv {};

    laptop-output = { host }: {
      homeManager = {
        services.kanshi.settings = [
          {
            output = {
              criteria = "eDP-1";
              alias = "laptopScreen";
            };
          }
        ];
      };
    };

    dual-monitor-outputs = { host }: {
      homeManager = {
        services.kanshi.settings = [
          {
            output = {
              criteria = mainMonitor;
              alias = "mainMonitor";
              mode = "2560x1440";
            };
          }
          {
            output = {
              criteria = sideMonitor;
              alias = "sideMonitor";
              transform = "270";
              mode = "1920x1080";
            };
          }
        ];
      };
    };
  in
  {
    provides = {
      laptop = {
        includes = [
          laptop-output
          dual-monitor-outputs
        ];

        homeManager = { pkgs, ... }: {
          services.kanshi = {
            enable = true;

            settings = [
              {
                profile = {
                  name = "undocked";
                  outputs = [
                    {
                      criteria = "$laptopScreen";
                    }
                  ];
                };
              }
              {
                profile = {
                  name = "docked";
                  exec = [
                    "${setPrimaryMonitor pkgs} \"${mainMonitor}\""
                    "${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor 1 \"desc:${mainMonitor}\""
                  ];
                  outputs = [
                    {
                      criteria = "$laptopScreen";
                      status = "disable";
                    }
                    {
                      criteria = "$mainMonitor";
                      position = "0,0";
                    }
                    {
                      criteria = "$sideMonitor";
                      position = "2560,0";
                    }
                  ];
                };
              }
            ];
          };
        };
      };

      pc = {
        includes = [
          dual-monitor-outputs
        ];

        homeManager = { pkgs, ... }: {
          services.kanshi = {
            enable = true;

            settings = [
              {
                profile = {
                  name = "PC";
                  exec = [
                    "${setPrimaryMonitor pkgs} \"${mainMonitor}\""
                    "${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor 1 \"desc:${mainMonitor}\""
                  ];
                  outputs = [
                    {
                      criteria = "$mainMonitor";
                      position = "0,0";
                    }
                    {
                      criteria = "$sideMonitor";
                      position = "2560,0";
                    }
                  ];
                };
              }
            ];
          };
        };
      };
    };
  };
}
