{ pkgs, inputs, ... }: {
	imports = [
		inputs.walker.homeManagerModules.default
	];

	home = {
		packages = with pkgs; [
			walker
		];
	};

	programs.walker = {
		enable = true;
		package = pkgs.walker;
		runAsService = true;

		config = {
			app_launch_prefix = "uwsm app -- ";

			websearch.prefix = "?";
			switcher.prefix = "/";
		};
	};
}
