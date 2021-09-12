{ ... }:

{
  imports = [
    ./util.nix
    ./communication.nix
    ./terminals.nix
    ./xorg.nix
    ./flakes.nix
    ./pulseaudio.nix
    ../hardware/default.nix
  ];
}
