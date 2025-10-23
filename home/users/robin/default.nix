{
  imports = [
    ../..
  ];

  home = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    file.".face".source = ./buizel.png;
  };

  programs.git = {
    userName = "Sunner";
    userEmail = "sunnerlp@gmail.com";

    signing = {
      signByDefault = true;
      key = "068C46171236B7AD"; # Needs to be imported
    };
  };

  programs = {
    vesktop.enable = true;
  };
}
