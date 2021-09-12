{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.communication;
in {
  options.teletypeOne.communication = {
    discord = mkEnableOption "Install discord.";
  };

  config = (mkMerge [
    (mkIf (cfg.discord) {
      environment.systemPackages = with pkgs; [discord];
    })
  ]);
}
