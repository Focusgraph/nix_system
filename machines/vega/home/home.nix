{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ../../../shared_home
    # ./impermanence.nix
    # ./niri.nix
    # ./noctalia.nix
    ./yazi.nix
    ./cava.nix
    ./keepassxc.nix
    ./librewolf.nix
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

  xdg.autostart.enable = true;

  programs = {
    home-manager.enable = true;  
    ghostty.enable = true;
    yazi.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita";
  };

}
