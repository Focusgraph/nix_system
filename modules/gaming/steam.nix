{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.millenium.overlays.default ];
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
  };
}
