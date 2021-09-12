{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.desktop;
in
{
	options.teletypeOne.hardware.desktop = mkEnableOption "Enable Desktop";

  config = mkIf cfg{
		boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
	  boot.initrd.kernelModules = [ "amdgpu" ];
	  boot.kernelModules = [ "kvm-amd" ];
	  boot.extraModulePackages = [ ];

		boot.kernelParams = [
	  "video=DP-3:1920x1080@75"
		"video=HDMI-A-1:1920x1080@75"
		];

		fileSystems."/" = {
			device = "/dev/disk/by-uuid/1f4bf4ce-121c-4e47-9b35-2481fe149361";
		  fsType = "ext4";
		};

		swapDevices = [ ];
  };
}
