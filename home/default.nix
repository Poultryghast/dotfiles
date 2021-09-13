{ pkgs, ... }:

{
  imports = [
    ./programs/rofi.nix
  ];
  programs.home-manager.enable = true;

  home = {
    username = "henry";
    homeDirectory = "/home/henry";
    stateVersion = "21.11";
    packages = with pkgs; [
      firefox
    ];
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      download = "$HOME/downloads";
      code = "$HOME/code";
      save = "$HOME/save";
    };
  };
}
