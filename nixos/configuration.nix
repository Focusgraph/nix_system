{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocales = [ "es_ES.UTF-8/UTF-8" ];
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "es_ES.UTF-8";
        LC_MEASUREMENT = "es_ES.UTF-8";
        LC_MONETARY = "es_ES.UTF-8";
        LC_NAME = "es_ES.UTF-8";
        LC_NUMERIC = "es_ES.UTF-8";
        LC_PAPER = "es_ES.UTF-8";
        LC_TELEPHONE = "es_ES.UTF-8";
        LC_TIME = "es_ES.UTF-8";
    };

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
        libgcc
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
            gc = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 1d";
        };
    };

    time.timeZone = "Europe/Madrid";

    console = {
        keyMap = "colemak";
    };

    hardware.bluetooth.enable = true;

    system.stateVersion = "25.11";
}
