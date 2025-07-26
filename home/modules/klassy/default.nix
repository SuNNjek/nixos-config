{ pkgs, ... }: {
	home = {
		packages = with pkgs; [
			(callPackage ./package.nix {
				version = "6.4";
				tag = "6.4.breeze6.4.0";
			})
		];
	};
}
