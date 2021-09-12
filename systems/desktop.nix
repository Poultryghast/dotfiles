inputs: {
  system = "x86_64-linux";

  modules = [
    ../nixos-modules/default.nix
    ({ pkgs, config, lib, ... }:
      let
        inherit (config.teletypeOne.pkgs) nixpkgs-unstable;
      in
        {
          teletypeOne = {

            terminals = {
              alacritty = true;
              termite = false;
            };

            filemanagers = {
              gui = false;
              tui = false;
            };

            zsh = {
              enabled = false;
              ohMy = false;
            };

            games = {
              steam = false;
              minecraft = false;
            };

            pulseaudio.enable = true;
            pipewire.enable = false;

            fonts = {
              firaCode = true;
            };

            communication = {
              free = false;
              nonFree = true;
              bullshit = false;
            };

            util = {
              xmonadUtil = true;
              neofetch = true;
              music = false;
              screenshot = false;
              theming = false;
              topFamily = false;
              driveUtil = false;
              emacs = false;
              media = false;
              encoding = false;
              pulseUtil = true;
              textUtil = false;
              office = false;
              password = false;
              compilerUtil = false;
              haskell = false;
              termUtil = false;
              painting = false;
            };

            xorg = {
              enable = true;
              gpu = "null";
              xmonad = true;
              xmobar = true;
              dunst = true;
              lightdm = true;
              libinput = true;
              flatInput = true;
            };

            networking  = {
              bluetooth = false;
              networkManager = false;
            };

            hardware.desktop = true;
            flakes.enable = true;
          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      time.timeZone = "America/New_York";

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

      # Defining users
      users.users.henry = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };

      nixpkgs.config.allowUnfree = true;
    })
  ];
}
