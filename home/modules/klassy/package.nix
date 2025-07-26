{
		fetchFromGitHub,
		lib,
		stdenv,
		cmake,
		extra-cmake-modules,
		kdePackages,
		qt6,

		version,
		rev,
		sha256,
		...
}: stdenv.mkDerivation {
		inherit version;

		pname = "klassy";

		vendorHash = null;

		src = fetchFromGitHub {
			inherit rev sha256;

			owner = "paulmcauley";
			repo = "klassy";
		};

		nativeBuildInputs = [
			cmake
			kdePackages.extra-cmake-modules

			kdePackages.wrapQtAppsHook
		];

		buildInputs = with kdePackages; [
			qtbase

			kcmutils
			kconfig
			kcolorscheme
			kcoreaddons
			kdecoration
			kguiaddons
			ki18n
			kiconthemes
			kwidgetsaddons
			kwindowsystem
			kwin
			kconfigwidgets
			frameworkintegration
		];

		cmakeFlags = [
			"-DCMAKE_INSTALL_PREFIX=$out"
			"-DCMAKE_BUILD_TYPE=Release"
			"-DBUILD_TESTING=off"
			"-DBUILD_QT5=off"
			"-DKDE_INSTALL_USE_QT_SYS_PATHS=ON"
		];

		meta = {
			description = "Klassy KDE window decoration";
			homepage = "https://github.com/paulmcauley/klassy";
			platforms = lib.platforms.linux;
		};
}
