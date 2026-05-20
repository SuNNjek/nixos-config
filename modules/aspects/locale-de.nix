let
  localeDef = { locale, timeZone, keyMap, xdgLayout }: {
    nixos = {
      i18n = {
        defaultLocale = locale;
        extraLocaleSettings = {
          LC_ALL = locale;
        };
      };

      time = { inherit timeZone; };
      console = { inherit keyMap; };
    };

    homeManager = {
      home = {
        keyboard.layout = xdgLayout;
      };
    };
  };
in
{
  den.aspects.locale-de =  localeDef {
    locale = "de_DE.UTF-8";
    keyMap = "de-latin1-nodeadkeys";
    timeZone = "Europe/Berlin";
    xdgLayout = "de";
  };
}
