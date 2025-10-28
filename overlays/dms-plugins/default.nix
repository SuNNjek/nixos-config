final: prev: {
  dms-plugins = {
    grimblast = prev.callPackage ./taylan-tatli.nix {
      plugin = "grimblast";
      sha256 = "sha256-qpR8WCd+Z0u3ehBEa58aRjZCbGNNnwslIrMS0jFO7Dw=";
    };
  };
}
