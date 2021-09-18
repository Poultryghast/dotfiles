{ pkgs, ... }:

{
  imports = [
    ./programs/vscode.nix
    ./programs/xmobar.nix
    ./programs/xmonad.nix
    ./programs/firefox.nix
    ./programs/alacritty.nix
  ];
  programs.home-manager.enable = true;

  home = {
    username = "henry";
    homeDirectory = "/home/henry";
    stateVersion = "21.05";
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
    };
  };
}
