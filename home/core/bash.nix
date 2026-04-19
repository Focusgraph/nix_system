{
  programs.bash = {
    enable = true;
    shellAliases = {
      nixos-switch = "nixos-rebuild build && nvd diff /run/current-system result && nixos-rebuild switch --sudo";
      nixos-build = "nixos-rebuild build && nvd diff /run/current-system result";
      nixos-build-update = "nix flake update && nixos-rebuild build && nvd diff /run/current-system result";
      ls = "eza";
      nix-search = "nix run nixpkgs#nix-search-cli -- -dr";
    };
    bashrcExtra = ''
      # Check package version from store
      function pkgv {
        realpath $(which $1)
      }
    '';
  };
}
