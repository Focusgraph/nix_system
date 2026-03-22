{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "niridium";
        email = "niridium@tuta.io";
      };
      init.defaultBranch = "main";
      core.editor = "hx";
      gpg.format = "ssh";
    };
    signing = {
      key = "/home/nixy/.ssh/key.pub";
      signByDefault = true;
    };
  };
}
