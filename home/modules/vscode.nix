{ lib, pkgs, username, ... }: {
	# Stylix installs it's own config file, making it read-only.
	# So if it's enabled for VSCode, I can't change any settings. That sucks :(
	stylix.targets.vscode.enable = false;

	programs.vscode = {
		enable = true;
	};
}
