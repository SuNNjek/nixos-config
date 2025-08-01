let
	workspaceCount = 9;
	forWorkspace = f: builtins.concatLists (builtins.genList (ws: f (ws + 1)) workspaceCount);
in {
	wayland.windowManager.hyprland.settings = {
		"$mod" = "SUPER";

		bind = [
			"$mod, T, exec, $terminal"
			
			"$mod, Q, killactive"
			"$mod SHIFT, Q, exec, wlogout"
			"$mod, SPACE, exec, walker"

			"$mod, k, swapwindow, u"
			"$mod, j, swapwindow, d"
			"$mod, h, swapwindow, l"
			"$mod, l, swapwindow, r"

			"$mod, left, workspace, r-1"
			"$mod, right, workspace, r+1"
			"$mod SHIFT, left, movetoworkspace, r-1"
			"$mod SHIFT, right, movetoworkspace, r+1"
		]
		++ forWorkspace (ws: [
			"$mod, ${toString ws}, workspace, ${toString ws}"
			"$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
		]);

		# $mod + Left Mouse to move the active window
		# $mod + Right Mouse to resize it
		bindm = [
			"$mod, mouse:272, movewindow"
			"$mod, mouse:273, resizewindow"
		];

		# $mod + Middle Mouse (=scrollwheel click) to toggle floating of current window
		bindc = [
			"$mod, mouse:274, togglefloating"
		];

		bindl = [
			", switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1,disable\""
			", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1,highres,auto,1\""

			", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
		];

		bindle = [
			", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
			", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
		];
	};
}
