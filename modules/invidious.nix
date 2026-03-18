{
  # No invidious companion
  services.invidious = {
    enable = true;
    port = 2560;
    settings = {
      https_only = true;
      external_port = 443;
      domain = "invidious.sole-alkaid.ts.net";
    };
  };
}
