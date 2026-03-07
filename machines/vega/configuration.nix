{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../common.nix
    ../../packages.nix
    ./hardware-configuration.nix
  ];

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
  hardware.bluetooth.enable = true;
  hardware.i2c.enable = true;

  networking = {
    hostName = "vega";
    networkmanager.wifi.powersave = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.users.nixy = {
    extraGroups = [
      "wheel"
      "i2c"
    ];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    # libvirtd.enable = true;
  };

  # environment.gnome.excludePackages = [
  #   pkgs.epiphany
  #   pkgs.gnome-text-editor
  #   pkgs.gnome-characters
  #   pkgs.gnome-contacts
  #   pkgs.gnome-font-viewer
  #   pkgs.gnome-maps
  #   pkgs.gnome-music
  #   pkgs.gnome-system-monitor
  #   pkgs.gnome-weather
  #   pkgs.gnome-connections
  #   pkgs.simple-scan
  #   pkgs.yelp
  # ];

  environment.systemPackages = [
    # Gnome
    # pkgs.gnomeExtensions.night-theme-switcher
    # pkgs.gnomeExtensions.appindicator
    # pkgs.gnome-tweaks
    # Gaming
    pkgs.moonlight-qt
    # Web browsers
    pkgs.ladybird
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    # Media
    pkgs.feishin
    pkgs.blanket
    # Tools
    pkgs.keepassxc
    pkgs.appimage-run
    # pkgs.libimobiledevice
    pkgs.distrobox
    # Code editors
    # pkgs.zed-editor
    # pkgs.package-version-server
    pkgs.ddcutil
    pkgs.jq
  ];

  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };

  services = {
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
    fwupd.enable = true;
    openssh.enable = true;
    openssh.openFirewall = false;
    tailscale = {
      enable = true;
      disableUpstreamLogging = true;
      extraSetFlags = [
        "--accept-routes"
      ];
    };
    fprintd.enable = true;
    # usbmuxd.enable = true;
    # qemuGuest.enable = true;
    # spice-vdagentd.enable = true;
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
    beesd.filesystems.root = {
      spec = "LABEL=nixos";
      hashTableSizeMB = 512;
      verbosity = "info";
      extraOptions = [
        "--loadavg-target"
        "5.0"
      ];
    };
    # pipewire.extraConfig = {
    #   pipewire."92-sunshine" = {
    #     "context.properties" = {
    #       "default.clock.rate" = 44100;
    #     };
    #   };
    #   pipewire-pulse."92-sunshine" = {
    #     context.modules = [
    #       {
    #         name = "libpipewire-module-protocol-pulse";
    #         args = {
    #           pulse.min.req = "32/44100";
    #           pulse.default.req = "32/44100";
    #           pulse.max.req = "32/44100";
    #           pulse.min.quantum = "32/44100";
    #           pulse.max.quantum = "32/44100";
    #         };
    #       }
    #     ];
    #   };
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
    regreet.enable = true;
    niri = {
      enable = true;
    };
    # virt-manager.enable = true;
    gamemode.enable = true;
    starship.enable = true;
    ssh = {
      # startAgent = true;
      extraConfig = "
            Host licher
                Hostname 100.70.166.15
                User nixy
            Host codeberg.org
                Hostname codeberg.org
                User git
                IdentityFile /home/nixy/.ssh/codeberg
            Host github.com
                HostName github.com
                User git
                IdentityFile /home/nixy/.ssh/github
            ";
    };
  };
  system.stateVersion = "25.11";
}
