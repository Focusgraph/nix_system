{
  system.stateVersion = "25.11";
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/tui
    ../../modules/gui
    ../../modules/filesystem
    ../../modules/filesystem/btrfs_subvolumes_luks.nix
    ../../modules/wireless.nix
    ../../modules/laptop.nix
    ../../modules/tailscale.nix
    ../../modules/gaming/factorio_login.nix
    ../../modules/gaming/steam.nix
  ];
}
