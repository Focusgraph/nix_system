{ ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./boot.nix
        ./dev.nix
        ./network.nix
        ./packages.nix
        ./flatpak.nix
        ./misc.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

    users.users.nixy = {
            isNormalUser = true;
            home = "/home/nixy";
            extraGroups = [ "wheel" "gamemode" ];
    };

    services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm.enable = true;
        tailscale.enable = true;
        fprintd.enable = true;
    };

    programs = {
      gamemode.enable = true;
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
            switch = "nixos-rebuild switch --sudo";
            please = "sudo !!";
        };
    };

    system.stateVersion = "25.11";
}
