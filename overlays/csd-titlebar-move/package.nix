{
	fetchFromGitHub,
	lib,

	hyprland,
	hyprlandPlugins,
	rev,
	sha256,
		...
}: hyprlandPlugins.mkHyprlandPlugin hyprland {
	pluginName = "csd-titlebar-move";
	version = "0.1"; # Not sure what to put here tbh

	src = fetchFromGitHub {
		inherit rev sha256;

		owner = "khalid151";
		repo = "csd-titlebar-move";
	};

	installPhase = ''
		mkdir -p $out/lib/
		cp csd-titlebar-move.so $out/lib/libcsd-titlebar-move.so
	'';

	meta = {
		description = "CSD titlebar move";
		homepage = "https://github.com/khalid151/csd-titlebar-move";
		platforms = lib.platforms.linux;
	};
}

