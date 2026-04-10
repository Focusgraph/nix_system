{
  programs.bash = {
    enable = true;
    shellAliases = {
      switch = "pushd ~/nixos && nixos-rebuild build && nvd diff /run/current-system result && nixos-rebuild switch --sudo && popd";
      ls = "eza";
      nix-search = "nix run nixpkgs#nix-search-cli -- -dr";
    };
    bashrcExtra =
    ''
      # Check package version from store
      function pkgv {
        realpath $(which $1)
      }
    '';
  };
}
