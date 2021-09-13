{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "pata_atiixp" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "amdgpu" "kvm-amd" ];
  boot.extraModulePackages = [ ];

  services.xserver.displayManager.sessionCommands = ''${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output DVI-D-0 --off'';
  boot.kernelParams = [
    "video=DP-3:1920x1080@75"
    "video=HDMI-A-1:1920x1080@75"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1f4bf4ce-121c-4e47-9b35-2481fe149361";
    fsType = "ext4";
  };

  swapDevices = [ ];
}
