{
	services.mako = {
		enable = true;

		settings = {
			anchor = "bottom-right";
			#font = "sans-serif";

			format = ''<b>%s</b> - <span font="10"><i>%a</i></span>\n%b'';
			
			#background-color = "#80808080";
			#text-color = "#FFFFFF";
			#progress-color = "source #000000";
			
			border-size = 1;
			#border-color = "#FFFFFF";
			border-radius = 8;
			
			margin = 8;
			padding = "8,16";
			outer-margin = 8;

			default-timeout = 15000;

			"urgency=high" = {
				#background-color = "#DC143C80";
				#progress-color = "source #DC143C";
				#border-color = "#DC143C";
				default-timeout = 0;
			};
		};
	};
}
