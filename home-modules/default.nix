{ pkgs, ... }:
{
  imports = [
    ./submodules/essentials.nix
    ./submodules/bash.nix
    ./submodules/ssh.nix
    ./submodules/git.nix
    ./submodules/helix.nix
    ./submodules/btop.nix
    ./submodules/yazi.nix
    ./submodules/ghostty.nix
    ./submodules/eza.nix
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
      pkgs.ggshield
      pkgs.git-conventional-commits
      pkgs.pre-commit
      pkgs.nautilus
    ];
  };
  xdg.autostart.enable = true;
  programs.home-manager.enable = true;

  dconf.enable = true;

  # services = {
  #   udiskie.enable = true; # Auto mount USB Storage Devices
  # };
}
