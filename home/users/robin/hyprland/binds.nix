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
			"ALT, SPACE, exec, walker"

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
	};
}
