{
  programs.keepassxc = {
    enable = true;
    autostart = true;
    settings = {
      General = {
        BackupBeforeSave = true;
        BackupFilePathPattern = "/home/nixy/Documents/Keepass_Old/{DB_FILENAME}.old.kdbx";
        ConfigVersion = 2;
        SingleInstance = true;
      };
      GUI = {
        ColorPasswords = true;
        CompactMode = false;
        MinimizeOnClose = true;
        MinimizeOnStartup = true;
        MinimizeToTray = true;
        ShowTrayIcon = true;
        TrayIconAppearance = "colorful";
      };
      Security = {
        ClearClipboard = false;
        LockDatabaseIdle = false;
      };
      Browser = {
        Enabled = true;
        UpdateBinaryPath = false;
      };
    };
  };
}
