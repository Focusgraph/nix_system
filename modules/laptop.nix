{
  networking.networkmanager.wifi.powersave = true;
  powerManagement.powertop.enable = true;
  services = {
    upower.enable = true; # Battery report
    fprintd.enable = true; # Fingerprint reader
  };
}
