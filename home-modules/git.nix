{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "focusgraph";
        email = "ruben.ledesma.go@protonmail.com";
      };
      init.defaultBranch = "main";
      core.editor = "hx";
      gpg.format = "ssh";
    };
    signing = {
      key = "/home/nixy/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
}
