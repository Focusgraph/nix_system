{ pkgs, ... }:
{
  home.stateVersion = "25.11";
  imports = [
    ../../home-modules
    ../../home-modules/qt.nix
    ../../home-modules/niri.nix
    ../../home-modules/noctalia.nix
    ../../home-modules/cava.nix
    ../../home-modules/keepassxc.nix
    # ../../home-modules/librewolf.nix
    ../../home-modules/firefox.nix
  ];
  home.packages = [
    pkgs.loupe
    pkgs.showtime
    pkgs.moonlight-qt
    pkgs.ladybird
    pkgs.ddcutil
    pkgs.jq
    pkgs.mpv
    pkgs.tutanota-desktop
    pkgs.factorio
  ];
}
