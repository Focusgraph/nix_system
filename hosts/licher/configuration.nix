{ pkgs, pkgsUnstable, ... }:
{
  system.stateVersion = "25.11";
  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/glance.nix
    ../../modules/redlib.nix
    ../../modules/invidious.nix
    ../../modules/sunshine.nix
    ../../modules/kde.nix
  ];
  users.users.nixy.extraGroups = [ "wheel" "immich" "input" "video" ];
  networking.hostName = "licher";
  zramSwap.enable = true;
  boot = {
    kernelParams = [ "amdgpu.virtual_display=0000:0c:00.0,1" ];
    swraid.mdadmConf = "MAILADDR ruben.ledesma.go@protonmail.com";
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    pkgs.mdadm
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
    pkgsUnstable.lutris-free
    pkgs.mangohud
    pkgs.wineWow64Packages.staging
    pkgs.winetricks
  ];
  programs.steam.enable = true;
  services = {
    displayManager.autoLogin = {
      enable = true;
      user = "nixy";
    };
    tailscale = {
      enable = true;
      disableUpstreamLogging = true;
    };
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
    beesd.filesystems = {
      root = {
        spec = "/";
        hashTableSizeMB = 512;
        verbosity = "info";
        extraOptions = [ "--loadavg-target" "5.0" ];
      };
    };
    jellyfin.enable = true;
    actual.enable = true;
  };
}
