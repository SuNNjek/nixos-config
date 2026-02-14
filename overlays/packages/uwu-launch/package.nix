{
  writeShellApplication,

  proton-ge-bin,
  icoutils,
  umu-launcher,
}: writeShellApplication {
  # Like umu, but with the "m" inverted UwU
  name = "uwu-launch";

  runtimeInputs = [
    icoutils
    umu-launcher
  ];

  runtimeEnv = {
    PROTONPATH = "${proton-ge-bin.steamcompattool}/";
    PROTON_VERBS = "waitforexitandrun";

    PROTON_ENABLE_WOW64 = "1";

    MESA_SHADER_CACHE_MAX_SIZE = "1G";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_SIZE = "1073741824";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  };

  text = builtins.readFile ./uwu-launch.sh;
}
