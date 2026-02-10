{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
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
  fileSystems."/".options = [ "compress=zstd" ];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = "all";
  environment.sessionVariables.LANG = lib.mkForce null; # Should fix locales not appearing
  console.keyMap = "colemak";
  time.timeZone = "Europe/Madrid";
  powerManagement.powertop.enable = true;
  security.rtkit.enable = true;
  hardware.bluetooth.enable = true;

  networking = {
    hostName = "vega";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = true;
    networkmanager.dns = "none";
    nameservers = [
      "194.242.2.3" # Mullvad DNS
    ];
  };

  environment.variables = {
    PATH = "\${PATH}:/home/nixy/.local/bin:/home/nixy/bash_scripts:/home/nixy/synclone";
  };

  users.users.nixy = {
    isNormalUser = true;
    home = "/home/nixy";
    extraGroups = [
      "wheel"
      "gamemode"
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig.useEmbeddedBitmaps = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
    ];
  };

  environment.gnome.excludePackages = [
    pkgs.epiphany
    pkgs.gnome-text-editor
    pkgs.gnome-characters
    pkgs.gnome-contacts
    pkgs.gnome-font-viewer
    pkgs.gnome-maps
    pkgs.gnome-music
    pkgs.gnome-system-monitor
    pkgs.gnome-weather
    pkgs.gnome-connections
    pkgs.simple-scan
    pkgs.yelp
  ];

  environment.systemPackages = [
    # Gnome
    pkgs.gnomeExtensions.night-theme-switcher
    pkgs.gnomeExtensions.appindicator
    pkgs.gnome-tweaks
    # Monitoring
    pkgs.btop
    # Nix
    pkgs.nil
    pkgs.nvd
    # Gaming
    pkgs.lutris-free
    pkgs.wineWow64Packages.staging
    pkgs.winetricks
    pkgs.mangohud
    pkgs.moonlight-qt
    # Web browsers
    pkgs.firefox
    pkgs.ladybird
    # inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    # Terminal
    pkgs.starship
    pkgs.fzf
    # Media
    pkgs.feishin
    pkgs.blanket
    # Tools
    pkgs.git
    pkgs.keepassxc
    pkgs.appimage-run
    pkgs.libimobiledevice
    # Code editors
    pkgs.helix
    pkgs.zed-editor
    pkgs.package-version-server
  ];

  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  services = {
    # desktopManager.plasma6.enable = true;
    # displayManager.sddm.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    tailscale.enable = true;
    tailscale.disableUpstreamLogging = true;
    fprintd.enable = true;
    usbmuxd.enable = true;
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
    flatpak = {
      enable = true;
      packages = [
      ];
    };
    syncthing = {
      enable = true;
      user = "nixy";
      dataDir = "/home/nixy";
      configDir = "/home/nixy/.config/syncthing";
      guiPasswordFile = "/home/nixy/syncthing_gui_password.txt";
      settings = {
        gui.user = "nixy";
        devices = {
          "pixel6" = {
            id = "4VGTGWP-F3ENL55-4PKBV4V-72JG2AR-6E2E5IU-NKSH6BJ-6LXVBC2-CI2ZJA7";
          };
        };
        folders = {
          "Keepass" = {
            path = "/home/nixy/Keepass";
            devices = [ "pixel6" ];
          };
          "Share" = {
            path = "/home/nixy/Share";
            devices = [ "pixel6" ];
          };
        };
      };
    };
  };

  programs = {
    gamemode.enable = true;
    starship.enable = true;
    ssh = {
      # startAgent = true;
      extraConfig = "
            Host licher
                Hostname 192.168.18.8
                Port 22
                User nixy
                IdentityFile /home/nixy/.ssh/licher
            Host tslicher
                Hostname 100.70.166.15
                User lich
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
    bash.shellAliases = {
      build = "pushd ~/nixos && nix flake update && nixos-rebuild build && nvd diff /run/current-system result && popd";
      switch = "nixos-rebuild switch --sudo";
      bswitch = "build && switch";
      please = "sudo !!";
    };
    dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/mutter" = {
            experimental-features = [
              "variable-refresh-rate"
              "xwayland-native-scaling"
              "autoclose-xwayland"
            ];
          };
        };
      }
    ];
    firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };

  system.stateVersion = "25.11";
}
