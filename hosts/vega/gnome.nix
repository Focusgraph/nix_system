{ pkgs, ... }:
{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = [
    pkgs.gnomeExtensions.night-theme-switcher
    pkgs.gnomeExtensions.appindicator
    pkgs.gnome-tweaks
  ];

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
}
