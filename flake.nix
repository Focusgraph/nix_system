{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Infrastructure
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # User Environment
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    millennium.url = "github:SteamClientHomebrew/Millennium/e2c66a2?dir=packages/nix";

    # System Tools
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Security
    agenix.url = "github:ryantm/agenix";

    # Network/Browser
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";

    # Utilities
    direnv-instant.url = "github:Mic92/direnv-instant";
  };

  outputs =
    inputs@{
      nixpkgs,
      disko,
      impermanence,
      home-manager,
      noctalia,
      niri,
      nix-index-database,
      agenix,
      arkenfox,
      direnv-instant,
      self,
      ...
    }:
    {
      # devShells.x86_64-linux = {
      #   default =
      #     let
      #       system = "x86_64-linux";
      #       pkgs = import nixpkgs { inherit system; };
      #     in
      #     with pkgs;
      #     mkShell {
      #       packages = [
      #         # Infra
      #         cachix
      #         git-conventional-commits
      #         pre-commit

      #         # Languages
      #         nil
      #         nixd
      #         nixfmt-tree
      #       ];
      #     };
      # };

      nixosConfigurations = {
        vega =
          let
            username = "nixy";
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs username;
              hostname = "vega";
              swapspace = 8;
              systemdisk = "/dev/nvme0n1";
            };
            modules = [
              ./hosts/vega
              disko.nixosModules.disko
              nix-index-database.nixosModules.default
              agenix.nixosModules.default
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = ./home/hosts/vega.nix;
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.backupFileExtension = "bkp";
                nixpkgs.overlays = [ niri.overlays.niri ];
                age.identityPaths = [ "/home/nixy/.ssh/key" ];
              }
            ];
          };
        licher =
          let
            username = "nixy";
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs username;
              hostname = "licher";
              swapspace = 8;
              systemdisk = "/dev/sdc";
              serverdirectory = "/storage";
              virtual_display = "amdgpu.virtual_display=0000:0c:00.0,1";
              interface = "enp9s0";
            };
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
