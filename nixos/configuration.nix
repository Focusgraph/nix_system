{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

    i18n.defaultLocale = "en_US.UTF-8";

    environment.systemPackages = with pkgs; [
        btop
        fastfetch
        git
        neovim
	      noto-fonts
	      noto-fonts-color-emoji
	      noto-fonts-monochrome-emoji
	      noto-fonts-cjk-sans
        nil
        nvd
        feishin
        firefox
        ladybird
        lutris-free
        starship
	      kdePackages.kate
	      gnomeExtensions.night-theme-switcher

        # LazyVim setup
	      vimPlugins.LazyVim
        python3
        luajitPackages.luarocks
        lua51Packages.lua
        ripgrep
        fd
        lazygit
        fzf
        gcc
        unzip
        wget
        ghostty
        imagemagick
        git-spice
        tectonic
        mermaid-cli
        sqlite
#        kdePackages.yakuake
#        kdePackages.filelight
    ];

    # --Filesystem--
    nix.settings.auto-optimise-store = true; # Create hard links

    fileSystems = {
        "/".options = [ "compress=zstd" ];
    };

    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 6*1024; # 6G
    }];
    # --------------

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

    networking = { hostName = "nixos"; networkmanager.enable = true; };

    users.users.nixy = {
            isNormalUser = true;
            home = "/home/nixy";
            extraGroups = [ "wheel" ];
    };

    services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm.enable = true;
        tailscale.enable = true;
        fprintd.enable = true;

        # --btrfs--
        btrfs.autoScrub = {
            enable = true;
            fileSystems = [ "/"];
        };
        beesd.filesystems.root = {
            spec = "LABEL=nixos";
            hashTableSizeMB = 512;
            verbosity = "info";
            extraOptions = [ "--loadavg-target" "5.0" ];
        };
        # ---------
    };

    programs = {
      starship.enable = true;
	    neovim = {
	      enable = true;
	      defaultEditor = true;
	      viAlias = true;
	      vimAlias = true;
	    };
    	ssh = {
            startAgent = true;
            extraConfig = "
            Host btarch
                Hostname 192.168.18.8
                Port 22
                User barchy
            Host tsbtarch
                Hostname 100.68.169.70
                Port 22
                User barchy
            Host codeberg.org
                Hostname codeberg.org
                User git
                IdentityFile /home/nixy/.ssh/codeberg
            ";
        };
        firefox = {
            enable = true;
            preferences = { "widget.use-xdg-desktop-portal.file-picker" = 1; };
        };
        bash.shellAliases = {
            updiff = "nixos-rebuild build --upgrade --sudo && nvd diff /run/current-system result";
            gc = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 7d";
        };
    };

    time.timeZone = "Europe/Madrid";

    console = {
        keyMap = "colemak";
    };

    hardware.bluetooth.enable = true;

    system.stateVersion = "25.11";
}
