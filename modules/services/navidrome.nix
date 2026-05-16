{ serverdirectory, ... }:
{
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "${serverdirectory}/Backups/vega/Music";

      EnableInsightsCollector = true;

      Backup.Path = "${serverdirectory}/Backups/licher/Navidrome";
      Backup.Schedule = "0 0 * * *";
      Backup.Count = 7;
    };
  };
}
