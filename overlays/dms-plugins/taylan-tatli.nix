{
  fetchFromGitHub,
  
  plugin,
  rev ? "2fa71a37f7ba411991a9e76baa3637351830ec6a",
  sha256,
  ...
}: fetchFromGitHub {
  inherit rev sha256;

  owner = "TaylanTatli";
  repo = "dms-plugins";

  rootDir = plugin;
}
