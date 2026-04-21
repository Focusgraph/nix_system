{
  lib,
  ...
}:
{
  imports = [
    ./audio.nix
    ./boot.nix
    ./network.nix
    ./nix_ld.nix
    ./nix_settings.nix
    ./oom.nix
    # ./sops.nix
    ./unstable_packages.nix
    ./users.nix
  ];

  services.gnome.gnome-keyring.enable = lib.mkForce false;

  console.keyMap = "colemak";
  time.timeZone = "Europe/Madrid";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = "all";
  };

  services = {
    power-profiles-daemon.enable = true;
    fwupd.enable = true; # Firmware updates
  };
}
