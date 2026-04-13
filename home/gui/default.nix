{ pkgs, ... }:
{
  imports = [
    ./ghostty.nix
    ./gtk.nix
    ./niri.nix
    ./noctalia.nix
    ./qt.nix
    ./wayland.nix
  ];
  home.packages = [
    pkgs.nautilus
    pkgs.ddcutil
    pkgs.loupe
    pkgs.showtime
    pkgs.mpv
    pkgs.tutanota-desktop
  ];
}
