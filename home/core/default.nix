{
  pkgs,
  ...
}:
{
  imports = [
    ./bash.nix
    ./eza.nix
    ./git.nix
    ./helix.nix
    ./keepassxc.nix
    ./ssh.nix
  ];
  home = {
    username = "nixy";
    homeDirectory = "/home/nixy";
    sessionPath = [
      "$HOME/nixos"
      "$HOME/my_scripts"
      "$HOME/my_scripts/nixos"
    ];
    packages = [
      pkgs.nvd
      pkgs.nil
      pkgs.fastfetch
    ];
  };
  xdg.autostart.enable = true;
  programs.home-manager.enable = true;
  programs = {
    starship.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
  };
}
