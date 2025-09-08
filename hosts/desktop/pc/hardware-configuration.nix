{ inputs, config, ... }:
{
	imports = [
		inputs.nixos-hardware.nixosModules.common-cpu-amd
		inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
		inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
		inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
		inputs.nixos-hardware.nixosModules.common-pc
		inputs.nixos-hardware.nixosModules.common-pc-ssd
	];

	boot = {
		kernelModules = [ "kvm-amd" ];
		kernelParams = [ "module_blacklist=amdgpu" ];
		extraModulePackages = [ ];

		initrd = {
			availableKernelModules = [
				"xhci_pci"
				"nvme"
				"ahci"
				"thunderbolt"
				"usb_storage"
				"usbhid"
				"sd_mod"
				"sr_mod"
			];

			kernelModules = [ ];
		};
	};

	nixpkgs.hostPlatform = "x86_64-linux";

	hardware = {
		enableRedistributableFirmware = true;

		nvidia = {
      open = true;

      # HACK: Use more recent version of nvidia drivers that build with kernel 6.16
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "580.82.07";
        sha256_64bit = "sha256-Bh5I4R/lUiMglYEdCxzqm3GLolQNYFB0/yJ/zgYoeYw=";
        openSha256 = "sha256-8/7ZrcwBMgrBtxebYtCcH5A51u3lAxXTCY00LElZz08=";
        settingsSha256 = "sha256-lx1WZHsW7eKFXvi03dAML6BoC5glEn63Tuiz3T867nY=";
        usePersistenced = false;
      };
    };
	};
}
