{ pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  fonts.fonts = [
    ( pkgs.callPackage ../packages/fonts/oldschool-pc.nix {} )
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
    extraGroups = [ "wheel" "docker" ];
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
      gimp obs-studio
      haskellPackages.xmobar rofi
      spotify playerctl vlc
      firefox qutebrowser
      (pkgs.discord.overrideAttrs (old: rec {
        version = "0.0.16";
	src = fetchurl {
	  url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
	  sha256 = "1s9qym58cjm8m8kg3zywvwai2i3adiq6sdayygk2zv72ry74ldai";
	};
      }))
      slack
      alacritty
      git neovim nodejs
      minecraft multimc steam
      ( pkgs.callPackage ../packages/games/lunar.nix {} )
    ];
    interactiveShellInit = ''
      alias music='cvlc /home/henry/songs'
    '';
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    registry.nixpkgs.flake = nixpkgs;
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "21.05";
}
