{ pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  # GRUB with a windows entry
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    extraEntries = ''
      menuentry "Windows 10" {
        chainloader (hd0,1)+1
      }
    '';
    splashImage = null;
  };

  time.timeZone = "America/New_York";

  users.users.henry = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "lp" ];
  };

  hardware.pulseaudio.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = {
      enable = true;
      layout = "us";

      videoDrivers = [ "amdgpu" ];

      displayManager = {
        lightdm.enable = true;
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    registry.nixpkgs.flake = nixpkgs;
  };

  virtualisation.docker.enable = true;

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ epson-escpr ];

  system.stateVersion = "21.05";
}
