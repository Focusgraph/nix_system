{ swapspace, ... }:
{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = swapspace * 1024;
    }
  ];
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.max_pool_percent=20"
    "zswap.shrinker_enabled=1"
  ];
}
