{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.pulseaudio;
in {
  options.teletypeOne.pulseaudio = {
    enable = mkEnableOption "Enable pulseaudio.";
  };
  config = mkIf cfg.enable {
    sound.enable = true;
    hardware = {
      pulseaudio = {
       enable = true;
      };
      pulseaudio.support32Bit = true;
    };
    systemd.user.services.pulseaudio.enable = true;
  };
}
