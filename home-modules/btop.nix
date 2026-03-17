{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "noctalia";
      theme_background = true;
      truecolor = true;
      force_tty = false;
      vim_keys = true;
      rounded_corners = true;
      update_ms = 100;
      proc_sorting = "cpu lazy";
      proc_gradient = false;
      proc_filter_kernel = true;
      base_10_sizes = true;
      show_swap = true;
      swap_disk = false;
      net_auto = true;
      base_10_bitrate = "Auto";
    };
  };
}
