{
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      # auto-optimise-store = true;
      trusted-users = [ "nixy" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # gc = {
    #   automatic = true;
    #   dates = "daily";
    #   options = "--delete-older-than 7d";
    # };
  };
}
