{ config, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    factorio = pkgs.factorio.override {
      username = "focusgraph";
      token = config.sops.secrets."factorio_token".path;
    };
  };
}
