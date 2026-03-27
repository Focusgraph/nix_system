{
  services.tailscale = {
    enable = true;
    disableUpstreamLogging = true;
    extraSetFlags = [ "--accept-routes" ];
  };
}
