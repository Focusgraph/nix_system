{ pkgs, ... }:
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
    pkgs.lutris-free
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
    tailscale = {
      enable = true;
      disableUpstreamLogging = true;
      permitCertUid = "caddy";
    };
    caddy = {
      enable = true;
      virtualHosts."licher.sole-alkaid.ts.net".extraConfig = ''
        @no_slash {
          path_regexp ^/[^.]+$
          not path */ 
        }
        redir @no_slash {path}/

        handle_path /* { reverse_proxy localhost:5050}
        handle_path /jellyfin/* { reverse_proxy localhost:8096 }
        handle_path /redlib/* { reverse_proxy localhost:8080 }
      '';
    };
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
        pages = [{
          name = "Services";
          show-mobile-header = true;
          columns = [
          {
            size = "small";
            widgets = [
            {
              type = "calendar";
            }
            {
              type = "weather";
              location = "Marbella, Spain";
            }
            ];
          }
          {
            size = "full";
            widgets = [{
              type = "hacker-news";
              limit = 15;
              collapse-after = 5;
              # feeds = [{
              #   url = "https://feeds.bloomberg.com/markets/news.rss";
              #   title = "Bloomberg";
              # }];
            }];
          }
          ];
        }];
      };
    };
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;
    };
    redlib.enable = true; 
    jellyfin.enable = true;
    actual.enable = true;
  };
  system.stateVersion = "25.11";
}
