{ inputs, ... }: {
	imports = [
		inputs.hypotd.homeManagerModules.default
	];
	
	programs.hypotd = {
		enable = true;

		config = {
			provider = "bing";
		};
	};
}
