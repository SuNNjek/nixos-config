{ config, ... }: {
	services.mako = {
		enable = config.sunner.hyprland.enable;

		settings = {
			anchor = "bottom-right";
			format = ''<b>%s</b> - <span font="10"><i>%a</i></span>\n%b'';
			
			border-size = 1;
			border-radius = 8;
			
			margin = 8;
			padding = "8,16";
			outer-margin = 8;

			default-timeout = 15000;

			"urgency=high" = {
				default-timeout = 0;
			};
		};
	};
}
