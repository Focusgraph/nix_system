{
  imports = [
    ./essentials.nix
    ./bash.nix
    ./ssh.nix
    ./git.nix
    ./helix.nix
    ./btop.nix
    ./yazi.nix
    ./ghostty.nix
  ];
  home = {
    username = "nixy";
    homeDirectory = "/home/nixy";
    sessionPath = [ "$HOME/nixos" ];
  };
  xdg.autostart.enable = true;
  programs.home-manager.enable = true;
}
