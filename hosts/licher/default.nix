{
  system.stateVersion = "25.11";
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/tui
    ../../modules/filesystem
    ../../modules/filesystem/swraid.nix
    ../../modules/services
    ../../modules/tailscale.nix
    ../../modules/wakeonlan.nix
  ];
}
