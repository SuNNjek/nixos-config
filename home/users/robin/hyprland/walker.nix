{ config, pkgs, inputs, ... }: 
let
	inherit (config.lib.stylix) colors;
in {
	imports = [
		inputs.walker.homeManagerModules.default
	];

	programs.walker = {
		enable = true;
		package = pkgs.walker;
		runAsService = true;

		config = {
			app_launch_prefix = "uwsm app -- ";

			websearch.prefix = "?";
			switcher.prefix = "/";
		};

		theme = {
			style = with colors.withHashtag; ''
@define-color base00 ${base00}; @define-color base01 ${base01};
@define-color base02 ${base02}; @define-color base03 ${base03};
@define-color base04 ${base04}; @define-color base05 ${base05};
@define-color base06 ${base06}; @define-color base07 ${base07};

@define-color base08 ${base08}; @define-color base09 ${base09};
@define-color base0A ${base0A}; @define-color base0B ${base0B};
@define-color base0C ${base0C}; @define-color base0D ${base0D};
@define-color base0E ${base0E}; @define-color base0F ${base0F};

@define-color background ${base00};
@define-color foreground ${base05};
		'' + (builtins.readFile ./walker.css);

			layout = {
				ui = {
					anchors = {
						bottom = true;
						left = true;
						right = true;
						top = true;
					};

					window = {
						h_align = "fill";
						v_align = "fill";

						box = {
							h_align = "center";
							v_align = "center";
							width = 450;

							scroll.list = {
								item.icon.pixel_size = 24;
								margins.top = 8;
							};
						};
					};
				};
			};
		};
	};
}
