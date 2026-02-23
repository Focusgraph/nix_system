{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nvd
    pkgs.nil
    pkgs.git
    pkgs.helix
    pkgs.btop
    pkgs.starship
    pkgs.fzf
  ];
}
