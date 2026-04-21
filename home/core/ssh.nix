{
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "licher" = {
        hostname = "100.75.222.43";
        user = "nixy";
      };
      "codeberg.org" = {
        hostname = "codeberg.org";
        user = "git";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
      };
    };
    extraOptionOverrides = {
      "PasswordAuthentication" = "no";
      "KbdInteractiveAuthentication" = "no";
    };
  };
}
