{
	wayland.windowManager.hyprland.settings = {
		windowrule = [
			# Give kitty some transparency
			"opacity 0.75, class:kitty"

			# Launch Firefox PiP in floating mode
			"float, class:firefox, title:Picture-in-Picture"
		];

		layerrule = [
			"blur, waybar"
			
			"blur, notifications"
			"ignorezero, notifications"

			"blurpopups, walker"
		];

		workspace = [
			"w[tv1], gapsin:0, gapsout:0"
			"f[1], gapsin:0, gapsout:0"
		];
	};
}
