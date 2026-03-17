{ config, pkgs, ... }:

{
  boot = {
    loader.limine.enable = true;
    # loader.systemd-boot.enable = true;
    # loader.efi.canTouchEfiVariables = true;
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
    # secrets."invidious_companion_key" = {};
    # secrets."nextcloud_password" = {};
    secrets."nixy_password".neededForUsers = true;
  };

  users.users.nixy = {
    isNormalUser = true;
    home = "/home/nixy";
    # hashedPasswordFile = config.sops.secrets."nixy_password".path;
    password = "126436";
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
