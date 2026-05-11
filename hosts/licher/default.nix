{
  system.stateVersion = "25.11";
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/tui
    ../../modules/filesystem
    ../../modules/filesystem/btrfs_subvolumes.nix
    ../../modules/filesystem/swraid.nix
    ../../modules/services/openssh.nix
    ../../modules/services/immich.nix
    ../../modules/services/redlib.nix
    ../../modules/services/actual.nix
    ../../modules/services/navidrome.nix
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
