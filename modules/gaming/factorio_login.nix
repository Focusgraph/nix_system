{ config, ... }:
{
  age.secrets.factorio_token.file = ../../secrets/factorio_token.age;
  nixpkgs.config.packageOverrides = pkgs: {
    factorio = pkgs.factorio.override {
      username = "focusgraph";
      token = config.age.secrets.factorio_token.path;
    };
  };
}
