{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-flatpak,
    nix-index-database,
    zen-browser,
    sops-nix
  } @ inputs:
  {
    nixosConfigurations.vega = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./machines/vega/configuration.nix
        nix-flatpak.nixosModules.nix-flatpak
        nix-index-database.nixosModules.default
        sops-nix.nixosModules.default
      ];
    };
    nixosConfigurations.licher = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./machines/licher/configuration.nix
        sops-nix.nixosModules.default
      ];
    };
  };
}
