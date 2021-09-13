{ pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
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
    extraGroups = [ "wheel" ];
  };

  hardware.pulseaudio.enable = true;

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
        gdm.enable = true;
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      gimp
      haskellPackages.xmobar
      spotify playerctl vlc
      firefox
      discord slack
      alacritty
      git neovim
      minecraft multimc
    ];
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    registry.nixpkgs.flake = nixpkgs;
  };

  system.stateVersion = "21.05";

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [

    ];
    fontconfig = {
      defaultFonts = {

      };
    };
  };
}
