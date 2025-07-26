{ pkgs, ... }: {
	home = {
		packages = with pkgs; [
			(callPackage ./package.nix {
				version = "6.4";
				rev = "6.4.breeze6.4.0";
        sha256 = "sha256-+bYS2Upr84BS0IdA0HlCK0FF05yIMVbRvB8jlN5EOUM=";
			})
		];
	};
}
