{
  # Needed until upsteam nixpkgs updates cacert to 3.131.1
  # https://emudhra.we-have-a-problem.com/
  den.aspects.distrust-emudhra = {
    nixos = { ... }: {
      security.pki.caCertificateBlacklist = [
        "Comodo AAA Services root"
        "emSign ECC Root CA - G3"
      ];
    };
  };
}
