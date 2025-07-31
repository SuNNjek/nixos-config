{
	wayland.windowManager.hyprland.settings = {
		windowrule = [
			# Give kitty some transparency
			"opacity 0.75, class:kitty"

			# Launch Firefox PiP in floating mode
			"float, class:firefox, title:Picture-in-Picture"

			"bordersize 0, floating:0, onworkspace:w[tv1]"
			"rounding 0, floating:0, onworkspace:w[tv1]"
			"bordersize 0, floating:0, onworkspace:f[1]"
			"rounding 0, floating:0, onworkspace:f[1]"
		];

		layerrule = [
			"blur, waybar"
			
			"blur, notifications"
			"ignorezero, notifications"

			"dimaround, walker"
			"blur, walker"
		];

		workspace = [
			"w[tv1], gapsin:0, gapsout:0"
			"f[1], gapsin:0, gapsout:0"
		];
	};
}
