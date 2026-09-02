{
  fetchFromGitHub,
  python3Packages,
  wrapGAppsNoGuiHook,
}:
python3Packages.buildPythonApplication rec {
  pname = "python-validity";
  version = "0.15";

  src = fetchFromGitHub {
    owner = "uunicorn";
    repo = pname;
    rev = version;
    hash = "sha256-RflX7e6nd11pSg8mh3mjZiVGNUSdox/SKXHR4W+PhMs=";
  };

  patches = [
    ./setup.py.patch
  ];

  pyproject = true;
  build-system = with python3Packages; [
    setuptools
  ];

  nativeBuildInputs = [
    wrapGAppsNoGuiHook
  ];

  propagatedBuildInputs = with python3Packages; [
    cryptography
    pyusb
    pyyaml
    dbus-python
    pygobject3
  ];

  postInstall = ''
    install -Dm644 debian/python3-validity.udev $out/lib/udev/rules.d/40-python3-validity.rules
    install -Dm644 LICENSE $out/share/licenses/${pname}/LICENSE
  '';
}
