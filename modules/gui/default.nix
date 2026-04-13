{
  config,
  pkgs,
  pkgsUnstable,
  username,
  ...
}:
{
  # Backlight control
  hardware.i2c.enable = true;
  users.users.${username}.extraGroups = [ "i2c" ];

  # Desktop Environment
  # nixpkgs.overlays = [ niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${config.programs.niri.package}/bin/niri-session";
      user = "${username}";
    };
  };
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ]; # Needed when Desktop Environment is installed with Home Manager

  environment.systemPackages = [
    pkgsUnstable.gelly
  ];

  services.gvfs.enable = true; # Filesystems tool for Nautilus
}
