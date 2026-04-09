{ config, pkgsUnstable, lib, ... }:
{
  system.stateVersion = "25.11";
  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/laptop.nix
    ../../modules/tailscale.nix
    ../../modules/btrfs_subvolumes_luks.nix
    ../../modules/zswap.nix
    ../../modules/factorio_login.nix
  ];
  users.users.nixy.extraGroups = [ "wheel" "i2c" "podman" ];
  networking.hostName = "vega";
  hardware.bluetooth.enable = true;
  environment.systemPackages = [
    pkgsUnstable.gelly
    pkgsUnstable.jellyfin-tui
  ];
  programs = {
    niri.enable = true;
  };
  services = {
    gnome.gnome-keyring.enable = lib.mkForce false; # Replaced by KeepassXC
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "nixy";
        };
      };
    };
  };
}
