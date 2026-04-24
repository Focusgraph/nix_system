{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
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
      url = "github:noctalia-dev/noctalia-shell/v4.7.6";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  outputs =
    inputs@{
      nix-index-database,
      nixpkgs-unstable,
      home-manager,
      impermanence,
      arkenfox,
      noctalia,
      nixpkgs,
      agenix,
      disko,
      niri,
      self,
      ...
    }:
    {
      nixosConfigurations = {
        vega =
          let
            username = "nixy";
            hostname = "vega";
            swapspace = 8;
            systemdisk = "/dev/nvme0n1";
            specialArgs = {
              inherit
                inputs
                username
                hostname
                swapspace
                systemdisk
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
              agenix.nixosModules.default
              niri.nixosModules.niri
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = ./home/hosts/vega.nix;
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.backupFileExtension = "bkp";
                nixpkgs.overlays = [ niri.overlays.niri ];
                age.identityPaths = [ "/home/${username}/.ssh/key" ];
              }
            ];
          };
        licher =
          let
            username = "nixy";
            hostname = "licher";
            swapspace = 8;
            systemdisk = "/dev/sdc";
            serverdirectory = "/storage";
            virtual_display = "amdgpu.virtual_display=0000:0c:00.0,1";
            interface = "enp9s0";
            specialArgs = {
              inherit
                inputs
                username
                hostname
                swapspace
                systemdisk
                serverdirectory
                virtual_display
                interface
                ;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              ./hosts/licher
              disko.nixosModules.disko
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
