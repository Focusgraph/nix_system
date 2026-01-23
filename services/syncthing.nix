{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "nixy";
    dataDir = "/home/nixy";
    configDir = "/home/nixy/.config/syncthing";
    guiPasswordFile = "/home/nixy/syncthing_gui_password.txt";
    settings = {
      gui.user = "nixy";
      devices = {
        "pixel6" = { id = "4VGTGWP-F3ENL55-4PKBV4V-72JG2AR-6E2E5IU-NKSH6BJ-6LXVBC2-CI2ZJA7"; };
      };
      folders = {
        "Keepass".path = "/home/nixy/Keepass";
        "Keepass".devices = [ "pixel6" ];
      };
    };
  };
}
