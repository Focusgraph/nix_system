{
  xdg.configFile."cava/config".force = true;
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 120;
        autosens = 1;
        bars = 0; #auto
        bar_width = 1;
        bar_spacing = 1;
        sleep_timer = 5;
      };
      input = {
        method = "pipewire";
        source = "auto";
      };
      output = {
        method = "noncurses";
        orientation = "horizontal";
        channels = "stereo";
        show_idle_bar_heads = 0;
        waveform = 0;
      };
      color.theme = "noctalia";
      smoothing.noise_reduction = 75;
    };
  };
}
