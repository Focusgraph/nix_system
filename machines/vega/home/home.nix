{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ../../../home-manager/home.nix
    ../../../home-manager/bash.nix
    ./niri.nix
    ./ssh.nix
  ];

  home = {
    username = "nixy";
    homeDirectory = "/home/nixy";
    stateVersion = "25.11";
    sessionPath = [
      "$HOME/nixos"
    ];
    packages = [
      pkgs.gnome-text-editor
      pkgs.loupe
      pkgs.showtime
    ];
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita";
  };

  programs = {
    home-manager.enable = true;  
    ghostty.enable = true;
    noctalia-shell.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
  };
}
