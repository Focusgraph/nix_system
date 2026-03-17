{ ... }:

{
  imports = [
    ../../shared_home
  ];

  home.username = "nixy";
  home.homeDirectory = "/home/nixy";
  home.stateVersion = "25.11";
  home.sessionPath = [
    "$HOME/nixos"
  ];

  programs = {
    home-manager.enable = true;  
    ghostty.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
  };
}
