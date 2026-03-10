{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ../../../shared_home
    ./niri.nix
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
      pkgs.cava
    ];
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita";
  };

  programs = {
    home-manager.enable = true;  
    noctalia-shell.enable = true;
    ghostty.enable = true;
    yazi.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
  };
}
