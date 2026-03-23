{ config, ... }:
{
  users.users.nixy = {
    isNormalUser = true;
    home = "/home/nixy";
    hashedPasswordFile = config.sops.secrets."nixy_password".path;
    extraGroups = [ "networkmanager" ];
  };
}
