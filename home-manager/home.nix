{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "licher" = {
        hostname = "100.70.166.15";
        user = "nixy";
      };
      "codeberg.org" = {
        hostname = "codeberg.org";
        user = "git";
        identityFile = "/home/nixy/.ssh/codeberg";
        addKeysToAgent = "yes";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/nixy/.ssh/github";
        addKeysToAgent = "yes";
      };
    };
  };
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core.editor = "hx";
      user = {
        name = "focusgraph";
        email = "ruben.ledesma.go@protonmail.com";
      };
      gpg.format = "ssh";
    };
    signing = {
      signByDefault = true;
    };
  };
}
