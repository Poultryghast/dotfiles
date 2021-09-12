{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware;
in
{
  options = {};
  imports =
    [
      ./desktop.nix
    ];
  config = {
    assertions = [
      {
        assertion =
          let
            selection = mapAttrsToList (system: enabled: {inherit system enabled; }) cfg;
          in
            count (x: x.enabled) selection == 1;
        message = "You must select exactly one hardware configuration";
      }
    ];
  };
}
