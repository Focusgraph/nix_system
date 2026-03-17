{
  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        ratio = [1 2 5];
        sort_by = "size";
        sort_reverse = true;
        sort_dir_first = true;
        linemode = "permissions";
        mouse_events = [ "click" "scroll" "touch" "move" "drag" ];
      };
      preview = {
        wrap = "yes";
        image_filter = "lanczos3";
        max_height = 1440;
        max_width = 2560;
      };
    };
  };
}
