{ pkgs, ... }:

{
  packages = with pkgs; [
    git
    git-conventional-commits
    pre-commit
  ];
  languages.nix.enable = true;
  cachix = {
    enable = true;
    pull = [ "niridium" ];
    # push = "niridium";
  };
}
