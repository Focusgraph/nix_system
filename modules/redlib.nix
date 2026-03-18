{ pkgsUnstable, ... }:
{
  services.redlib = {
    enable = true;
    package = pkgsUnstable.redlib;
    settings = {
      REDLIB_SFW_ONLY = "off";
      REDLIB_DEFAULT_THEME = "nord";
      REDLIB_DEFAULT_POST_SORT = "new";
      REDLIB_DEFAULT_COMMENT_SORT = "old";
      REDLIB_DEFAULT_BLUR_SPOILER = "on";
      REDLIB_DEFAULT_USE_HLS = "on";
      REDLIB_DEFAULT_REMOVE_DEFAULT_FEEDS = "on";
      REDLIB_DEFAULT_SUBSCRIPTIONS = "NixOS+selfhosted+linux+linux_gaming+homelab+grapheneOS+europe+wine_gaming";
    };
  };
}
