{ inputs, ... }: {
	imports = [
		inputs.nixos-hardware.nixosModules.common-cpu-amd
		inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
		inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
		inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
		inputs.nixos-hardware.nixosModules.common-pc
		inputs.nixos-hardware.nixosModules.common-pc-ssd
	];

	boot.initrd.availableKernelModules = [
		"xhci_pci"
		"nvme"
		"ahci"
		"thunderbolt"
		"usb_storage"
		"usbhid"
		"sd_mod"
		"sr_mod"
	];

	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-amd" ];
	boot.extraModulePackages = [ ];

	nixpkgs.hostPlatform = "x86_64-linux";

	hardware = {
		enableRedistributableFirmware = true;

		nvidia.open = true;
	};
}
