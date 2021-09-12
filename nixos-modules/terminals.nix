{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.terminals;
in {
  options.teletypeOne.terminals = {
    alacritty = mkEnableOption "Install alacritty.";
  };

  config = (mkMerge [
    (mkIf (cfg.alacritty) {
      environment.systemPackages = with pkgs; [alacritty];
    })
    ]);
}
