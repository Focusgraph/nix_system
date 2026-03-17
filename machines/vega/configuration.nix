{
  inputs,
  pkgs,
  pkgsUnstable,
  ...
}:

{
  system.stateVersion = "25.11";
  imports = [
    ../../common.nix
    ../../packages.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    # ./impermanence.nix
    # ./gnome.nix
  ];

  fileSystems."/".neededForBoot = true;

  boot = {
    kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=20"
      "zswap.shrinker_enabled=1"
    ];
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 24 * 1024;
    }
  ];

  powerManagement.powertop.enable = true;
  hardware = {
    bluetooth.enable = true;
    i2c.enable = true; # Backlight control
  };

  networking = {
    hostName = "vega";
    networkmanager.wifi.powersave = true;
  };

  users.users.nixy = {
    extraGroups = [
      "wheel"
      "i2c"
      "podman"
    ];
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    # libvirtd.enable = true;
  };

  environment.systemPackages = [
    # pkgs.nemo
    ### Gaming
    pkgs.moonlight-qt
    ### Web browsers
    pkgs.ladybird
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ### Media
    # pkgs.feishin
    pkgs.blanket
    pkgsUnstable.gelly
    ### Tools
    pkgs.appimage-run
    pkgs.ddcutil # Backlight control
    pkgs.jq # dpswitch.sh
    pkgs.distrobox
    ### Code editors
    # pkgs.zed-editor
    # pkgs.package-version-server
  ];

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true; # Battery report
    fprintd.enable = true; # Fingerprint reader
    fwupd.enable = true; # Firmware updates
    # gvfs.enable = true; # Gnome functionalities
    # tumbler.enable = true;

    tailscale = {
      enable = true;
      disableUpstreamLogging = true;
      extraSetFlags = [
        "--accept-routes"
      ];
    };
    # usbmuxd.enable = true;
    # qemuGuest.enable = true;
    # spice-vdagentd.enable = true;
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
    # beesd.filesystems.root = {
    #   spec = "/dev/nvme0n1p2";
    #   hashTableSizeMB = 512;
    #   verbosity = "info";
    #   extraOptions = [
    #     "--loadavg-target"
    #     "5.0"
    #   ];
    # };
    # flatpak = {
    #   enable = true;
    #   packages = [
    #   ];
    # };
    # syncthing = {
    #   enable = true;
    #   user = "nixy";
    #   dataDir = "/home/nixy";
    #   configDir = "/home/nixy/.config/syncthing";
    #   guiPasswordFile = config.sops.secrets."nixy_password".path;
    #   settings = {
    #     gui.user = "nixy";
    #     devices = {
    #       "pixel6" = {
    #         id = "4VGTGWP-F3ENL55-4PKBV4V-72JG2AR-6E2E5IU-NKSH6BJ-6LXVBC2-CI2ZJA7";
    #       };
    #     };
    #     folders = {
    #       "Keepass" = {
    #         path = "/home/nixy/Keepass";
    #         devices = [ "pixel6" ];
    #       };
    #     };
    #   };
    # };
  };

  programs = {
    regreet = {
      enable = true;
      settings = {
        application_prefer_dark_theme = true;
      };
    };
    niri = {
      enable = true;
    };
    # virt-manager.enable = true;
  };
}
