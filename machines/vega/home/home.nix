{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ../../../home-manager/home.nix
    ../../../home-manager/bash.nix
    ./niri.nix
    # ./ssh.nix
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
    git = {
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqBzty7pFZ5a1rBc+G8leMRKqNFezMpJU4Rc3SO3/Hi nixy@vega";
      };
    };
    ghostty.enable = true;
    noctalia-shell.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
  };
}
