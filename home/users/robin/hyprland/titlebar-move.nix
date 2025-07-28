{
	fetchFromGitHub,
	lib,

	hyprland,
	hyprlandPlugins,
		...
}: hyprlandPlugins.mkHyprlandPlugin hyprland {
	pluginName = "csd-titlebar-move";
	version = "0.1"; # Not sure what to put here tbh

	src = fetchFromGitHub {
		owner = "khalid151";
		repo = "csd-titlebar-move";
		rev = "ee9db13b7955a2b05cc660324d176538772adf17";
		sha256 = "sha256-219UocltY5RnJfkwmFu3oHuTjjKKsMIm1D41kOgiJqQ=";
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

