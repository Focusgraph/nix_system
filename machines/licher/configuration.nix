{ pkgs, config, pkgsUnstable, ... }:
let
  subreddits = [
    "NixOS"
    "selfhosted"
    "linux"
    "linux_gaming"
    "homelab"
    "grapheneOS"
    "europe"
    "wine_gaming"
  ];
in
{
  imports = [
    ../../common.nix
    ../../packages.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "licher";
  boot.kernelParams = [ "amdgpu.virtual_display=0000:0c:00.0,1" ];
  boot.swraid.mdadmConf = "MAILADDR ruben.ledesma.go@protonmail.com";
  zramSwap.enable = true;
  users.users.nixy = {
    extraGroups = [
      "wheel"
      "immich"
      "input"
      "video"
    ];
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

  programs = {
    starship.enable = true;
    steam.enable = true;
    ssh.extraConfig = "
        Host codeberg.org
          HostName codeberg.org
          User git
          IdentityFile /home/nixy/.ssh/codeberg
    ";
  };

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.autoLogin = {
      enable = true;
      user = "nixy";
    };
    udev.extraRules = ''
        KERNEL=="uinput", MODE="0660", GROUP="input", SYMLINK+="uinput"
    ''; # Fix input for sunshine

    openssh.enable = true;
    openssh.openFirewall = false;
    tailscale = {
      enable = true;
      disableUpstreamLogging = true;
      permitCertUid = "caddy";
      # extraSetFlags = [
      #   "--advertise-exit-node"
      # ];
    };
    # caddy = {
    #   enable = true;
    #   virtualHosts."licher.sole-alkaid.ts.net".extraConfig = ''
    #     @no_slash {
    #       path_regexp ^/[^.]+$
    #       not path */ 
    #     }
    #     redir @no_slash {path}/

    #     handle_path /* { reverse_proxy localhost:5050}
    #     handle_path /jellyfin/* { reverse_proxy localhost:8096 }
    #     handle_path /redlib/* { reverse_proxy licher:8080 }
    #   '';
    # };
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
    # webdav = {
    #   enable = true;
    #   settings = {
    #     address = "0.0.0.0";
    #     port = 6565;
    #     directory = "/storage/public";
    #     permissions = "RC";
    #     users = [
    #       {
    #         username = "nixy";
    #         password = "1234";
    #       }
    #     ];
    #   };
    # };
    glance = {
      enable = true;
      settings = {
        server = {
          port = 5050;
          host = "0.0.0.0";
          proxied = true;
        };
        branding = {
          custom-footer = ''<p>Powered by <a href="https://github.com/glanceapp/glance">Glance</a></p>'';
        };
        theme = {
          background-color = "0 0 16";
          primary-color = "43 59 81";
          positive-color = "61 66 44";
          negative-color = "6 96 59";
          contrast-multiplier = 1.3;
          disable-picker = true;
        };
        pages = [
          {
          name = "Home";
          show-mobile-header = true;
          columns = [
            {
            size = "small";
            widgets = [
              {
              type = "calendar";
              }
              {
              type = "monitor";
              cache = "1m";
              title = "Services";
              timeout = "1m";
              sites = [
                {
                title = "Jellyfin";
                url = "https://jellyfin.sole-alkaid.ts.net";
                check-url = "http://localhost:8096";
                icon = "di:jellyfin";
                }
                {
                title = "Actual Budget";
                url = "https://actual.sole-alkaid.ts.net";
                check-url = "http://localhost:3000";
                icon = "di:actual-budget";
                }
                {
                title = "Redlib";
                url = "https://redlib.sole-alkaid.ts.net";
                check-url = "http://localhost:8080";
                icon = "di:redlib";
                }];
              }
              {
              type = "server-stats";
              servers = [
                {
                type = "local";
                name = "Licher";
                }];   
              }];
            }
            {
            size = "full";
            widgets = [
              {
              type = "search";
              search-engine = "duckduckgo";
              bangs = [
                {
                title = "Youtube";
                shortcut = "!yt";
                url = "https://www.youtube.com/results?search_query={QUERY}";
                }
                {
                title = "Reddit";
                shortcut = "!rd";
                url = "https://redlib.sole-alkaid.ts.net/search?q={QUERY}";
                }];
              }
              {
              type = "to-do";
              }
              {
              type = "hacker-news";
              limit = 15;
              collapse-after = 5;
              # feeds = [{
              #   url = "https://feeds.bloomberg.com/markets/news.rss";
              #   title = "Bloomberg";
              # }];
              }];
            }];
          }];
      };
    };
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;
    };
    redlib = {
      enable = true; 
      package = pkgsUnstable.redlib;
      address = "127.0.0.1";
      settings = {
        REDLIB_SFW_ONLY = "off";
        REDLIB_DEFAULT_THEME = "nord";
        REDLIB_DEFAULT_POST_SORT = "new";
        REDLIB_DEFAULT_COMMENT_SORT = "old";
        REDLIB_DEFAULT_BLUR_SPOILER = "on";
        REDLIB_DEFAULT_USE_HLS = "on";
        REDLIB_DEFAULT_REMOVE_DEFAULT_FEEDS = "on";
        REDLIB_DEFAULT_SUBSCRIPTIONS = builtins.concatStringsSep "+" subreddits;
      };
    };
    # invidious = {
    #   enable = true;
    #   sig-helper.enable = true;
    #   port = 2560;
    #   address = "127.0.0.1";
    #   settings = {
    #   };
    # };
    jellyfin.enable = true;
    actual.enable = true;
  };
  system.stateVersion = "25.11";
}
