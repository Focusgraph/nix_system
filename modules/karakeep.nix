{
  services.karakeep = {
    enable = true;
    browser.enable = false;
    # environmentFile = "karakeep.env";
    extraEnvironment = {
      PORT = "6459";
    };
  };
}
