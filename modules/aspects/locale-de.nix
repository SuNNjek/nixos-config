let
  localeDef = { locale, timeZone, keyMap }: {
    i18n = {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_ALL = locale;
      };
    };

    time = { inherit timeZone; };
    console = { inherit keyMap; };
  };
in
{
  den.aspects.locale-de = {
    nixos = localeDef {
      locale = "de_DE.UTF-8";
      keyMap = "de-latin1-nodeadkeys";
      timeZone = "Europe/Berlin";
    };
  };
}
