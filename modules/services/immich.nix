{
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    # database.enable = false;
    openFirewall = true;
    mediaLocation = "/storage/immich";
  };
}
