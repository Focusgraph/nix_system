{ systemdisk, ... }:
{
  services = {
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
    beesd.filesystems.root = {
      spec = "/";
      hashTableSizeMB = 512;
      verbosity = "info";
      extraOptions = [
        "--loadavg-target"
        "5.0"
      ];
    };
  };
  fileSystems."/" = {
    options = [ "compress=zstd" ];
    neededForBoot = true;
  };
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = systemdisk;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  mountpoint = "/";
                  subvolumes = {
                    "/rootfs".mountpoint = "/";
                    "/persistent".mountpoint = "/persistent";
                    "/nix".mountpoint = "/nix";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
