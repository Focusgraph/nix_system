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
  ];
  home = {
    username = "nixy";
    homeDirectory = "/home/nixy";
    sessionPath = [ "$HOME/nixos" ];
    packages = [
      pkgs.nvd
      pkgs.nil
      pkgs.fastfetch
      pkgs.ggshield
    ];
  };
  xdg.autostart.enable = true;
  programs.home-manager.enable = true;
}
