let
  localeDef = { locale, timeZone, keyMap, xkbLayout }: {
    nixos = {
      i18n = {
        defaultLocale = locale;
        extraLocaleSettings = {
          LC_ALL = locale;
        };
      };

      time = { inherit timeZone; };
      console = { inherit keyMap; };

      services.xserver.xkb.layout = xkbLayout;
    };

    homeManager = {
      home = {
        keyboard.layout = xkbLayout;
      };
    };
  };
in
{
  den.aspects.locale-de =  localeDef {
    locale = "de_DE.UTF-8";
    keyMap = "de-latin1-nodeadkeys";
    timeZone = "Europe/Berlin";
    xkbLayout = "de";
  };
}
