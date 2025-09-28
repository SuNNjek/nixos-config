{ username, ... }: {
	programs.firefox = {
		enable = true;

		profiles = {
			"${username}" = {

			};
		};
	};

	stylix.targets.firefox.profileNames = [ username ];
}
