{ pkgs, ... }:
{
  system.stateVersion = "25.11";
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/tui
    ../../modules/filesystem/swap.nix
    ../../modules/services
    ../../modules/tailscale.nix
  ];
  boot = {
    kernelParams = [ "amdgpu.virtual_display=0000:0c:00.0,1" ];
    swraid.mdadmConf = "MAILADDR ruben.ledesma.go@protonmail.com";
  };
  environment.systemPackages = [
    pkgs.mdadm
  ];
  services = {
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
    beesd.filesystems = {
      root = {
        spec = "/";
        hashTableSizeMB = 512;
        verbosity = "info";
        extraOptions = [
          "--loadavg-target"
          "5.0"
        ];
      };
    };
  };
}
