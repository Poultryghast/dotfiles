{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neofetch
    system-config-printer
    gnome.quadrapassel
    gimp obs-studio
    haskellPackages.xmobar rofi
    playerctl vlc
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
    git neovim nodejs glow
    xorg.xmodmap
    minecraft multimc steam
    SDL2 glxinfo glmark2
    gcc cmake rustup cargo
    ( pkgs.callPackage ./lunar.nix {} )
  ];
}
