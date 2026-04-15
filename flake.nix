{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.5";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # zen-browser = {
    #   url = "github:youwen5/zen-browser-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      impermanence,
      disko,
      nix-index-database,
      home-manager,
      niri,
      noctalia,
      # zen-browser,
      sops-nix,
      arkenfox,
      ...
    }:
    {
      nixosConfigurations = {
        vega =
          let
            username = "nixy";
            hostname = "vega";
            swapspace = 8;
            specialArgs = {
              inherit
                inputs
                username
                hostname
                swapspace
                ;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              ./hosts/vega
              disko.nixosModules.disko
              nix-index-database.nixosModules.default
              sops-nix.nixosModules.default
              niri.nixosModules.niri
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = ./home/hosts/vega.nix;
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.backupFileExtension = "bkp";
                nixpkgs.overlays = [ niri.overlays.niri ];
              }
            ];
          };
        licher =
          let
            username = "nixy";
            hostname = "licher";
            swapspace = 8;
            specialArgs = {
              inherit
                inputs
                username
                hostname
                swapspace
                ;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              ./hosts/licher
              sops-nix.nixosModules.default
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = ./home/hosts/licher.nix;
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.backupFileExtension = "bkp";
              }
            ];
          };
      };
    };
}
