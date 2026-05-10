{
  system.stateVersion = "25.11";
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/tui
    ../../modules/filesystem
    ../../modules/filesystem/btrfs_subvolumes.nix
    ../../modules/filesystem/swraid.nix
    ../../modules/services
    ../../modules/services/immich.nix
    ../../modules/tailscale.nix
    ../../modules/wakeonlan.nix
  ];
  fileSystems."/storage" = {
    device = "/dev/md127";
    fsType = "btrfs";
    mountPoint = "/storage";
    options = [ "compress=zstd" ];
  };
  services.beesd.filesystems.storage = {
    spec = "/storage";
    hashTableSizeMB = 512;
    extraOptions = [
      "--loadavg-target"
      "5.0"
    ];
  };
}
