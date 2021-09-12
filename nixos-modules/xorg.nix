{ config, lib, pkgs, ... }:

with lib;
let
  xserver-enable = config.services.xserver.enable;
  cfg = config.teletypeOne.xorg;
in {
  options.teletypeOne.xorg = {
    enable = mkEnableOption "Xorg so graphical can happen";
    xmonad = mkEnableOption "Enable xmonad";
    xmobar = mkEnableOption "Enable xmobar";
    lightdm = mkEnableOption "Enable lightdm";
    sddm = mkEnableOption "Enable sddm";
  };
  config = mkIf cfg.enable (mkMerge [
    {
      services.xserver = {
        enable = true;
        windowManager = mkIf cfg.xmonad {
          xmonad.enable = true;
          xmonad.enableContribAndExtras = true;
        };

        displayManager = mkIf cfg.xmonad {
          lightdm.enable = mkIf cfg.lightdm true;
          sddm.enable = mkIf cfg.sddm true;
          defaultSession = "none+xmonad";
        };
      };

      environment.systemPackages = mkIf cfg.xmobar (with pkgs; [xmobar]);
    }
  ]);
}
