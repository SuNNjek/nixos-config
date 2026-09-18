final: prev: {
  ffms = prev.ffms.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [
      final.avisynthplus
    ];

    postPatch = ''
      substituteInPlace src/avisynth/avssources.h \
        --replace-fail "<avisynth.h>" "<avisynth/avisynth.h>"
    '';

    postInstall = final.lib.concatLines [
      old.postInstall

      ''
        mkdir $out/lib/avisynth
        ln -s $out/lib/libffms2${final.stdenv.hostPlatform.extensions.sharedLibrary} $out/lib/avisynth/libffms2${final.stdenv.hostPlatform.extensions.sharedLibrary}
      ''
    ];

    configureFlags = ["--enable-avisynth"];
  });
}
