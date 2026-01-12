{
  fileSystems = {
    "/".options = [ "compress=zstd" ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/" ];
  };

  services.beesd.filesystems.root = {
    spec = "LABEL=nixos";
    hashTableSizeMB = 512;
    verbosity = "info";
    extraOptions = [
      "--loadavg-target"
      "5.0"
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 12 * 1024;
    }
  ];
}
