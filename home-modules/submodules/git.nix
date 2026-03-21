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
      key = "/home/nixy/.ssh/public_key";
      signByDefault = true;
    };
  };
}
