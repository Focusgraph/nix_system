{
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        cleanup = true;
        nix_handler = "autodetect";
      };
      linux = {
        nix_arguments = "--flake";
      };
    };
  };
}
