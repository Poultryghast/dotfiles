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
            pulseaudio.enable = true;
            xorg = {
              enable = true;
              xmonad = true;
              xmobar = true;
              sddm = true;
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
