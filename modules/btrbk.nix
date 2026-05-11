{ pkgs, username, ... }:
{
  users.users."btrbk" = {
    isNormalUser = false;
    extraGroups = [ "wheel" "btrbk" ];
  };
  services.btrbk = {
    extraPackages = [ pkgs.sudo ];
    instances."remote_licher" = {
      onCalendar = "daily";
      settings = {
        # backend_remote = "btrfs-progs-sudo";
        ssh_identity = "/home/nixy/.ssh/btrbk";
        ssh_user = "nixy";
        volume."/" = {
          target = "ssh://licher/storage/Backups/vega";
          subvolume = "/";
        };
      };
    };
    # sshAccess = [
    #   {
    #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINd5EUnhBQnjYxcdkXVFdLW7wyxVi5fPGz8y+6UohS3Y";
    #   roles = [ "target" "info" "receive" ];
    #   }
    # ];
  };
  # security.sudo = {
  #   extraRules = [{
  #     commands = [
  #       {
  #         command = "${pkgs.btrfs-progs}/bin/btrfs";
  #         options = [ "NOPASSWD" ];
  #       }
  #     ];
  #     groups = [ "wheel" ];
  #   }];
  # };
}
