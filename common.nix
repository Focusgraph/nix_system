{
  config,
  pkgs,
  ...
}:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  fileSystems."/".options = [ "compress=zstd" ]; # Btrfs filesystems

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = "all";
  console.keyMap = "colemak";
  time.timeZone = "Europe/Madrid";
  security.rtkit.enable = true;

  networking = {
    networkmanager.enable = true;
    networkmanager.dns = "none";
    nameservers = [
      "194.242.2.3" # Mullvad DNS
    ];
  };

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    age.sshKeyPaths = [ "/home/nixy/.ssh/id_ed25519" ];
    age.keyFile = "/home/nixy/.config/sops/age/keys.txt";
    secrets."nixy_password" = {};
    secrets."nixy_password".neededForUsers = true;
  };

  users.users.nixy = {
    isNormalUser = true;
    home = "/home/nixy";
    hashedPasswordFile = config.sops.secrets."nixy_password".path;
  };

  programs.bash = {
    shellAliases = {
      gupdate = "pushd ~/nixos && nix flake update && nixos-rebuild build && nvd diff /run/current-system result && popd";
      switch = "nixos-rebuild switch --sudo";
      update = "gupdate && switch";
    };
    promptInit =
    ''
      eval "$(fzf --bash)"
      function pkgv {
        realpath $(which $1)
      }
    ''; # This is equivalent to .bashrc
  };
  fonts = {
    enableDefaultPackages = true;
    fontconfig.useEmbeddedBitmaps = true;
  };

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
}
