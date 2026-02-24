{ pkgs, config, inputs, ... }:
{
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

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
