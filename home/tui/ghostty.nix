{
  config,
  lib,
  ...
}:
{

  programs.ghostty = {
    enable = true;
    settings.theme = lib.mkIf config.programs.noctalia-shell.enable "noctalia";
  };
}
