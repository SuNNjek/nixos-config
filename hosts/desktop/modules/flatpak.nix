{ pkgs, ... }: {
	services.flatpak.enable = true;

	environment.systemPackages = with pkgs; [
		steam-devices-udev-rules
	];

	systemd.services.flatpak-repo = {
		enable = true;
		wantedBy = [ "multi-user.target" ];
		path = [ pkgs.flatpak ];
		script = ''
			flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
		'';
	};

	systemd.user.services.flatpak-repo = {
		enable = true;
		wantedBy = [ "default.target" ];
		path = [ pkgs.flatpak ];
		script = ''
			flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
		'';
	};
}
