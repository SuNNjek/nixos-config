final: prev: {
  obs-studio-nvidia = prev.obs-studio.override {
    cudaSupport = true;
  };
}
