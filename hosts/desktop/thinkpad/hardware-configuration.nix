{ inputs, ... }: {
	imports = [
		inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
	];

	boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-intel" ];
	boot.extraModulePackages = [ ];

	nixpkgs.hostPlatform = "x86_64-linux";
	hardware.enableRedistributableFirmware = true;
}
