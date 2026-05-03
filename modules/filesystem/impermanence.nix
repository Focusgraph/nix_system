{
  fileSystems."/persistent".neededForBoot = true;
  users.mutableUsers = false;
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/regreet"
      "/var/lib/systemd"
      "/var/lib/tailscale"
      "/var/lib/fprint"
      "/var/lib/bluetooth"
    ];
    files = [
      "/etc/machine-id"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
