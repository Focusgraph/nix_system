{
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [ ];
    extraPackages = with pkgs; [
    ];
    userSettings = {
      # === Agent & Predictions ===
      agent = {
        play_sound_when_agent_done = "when_hidden";
      };
      edit_predictions.mode = "eager";

      # === Autosave ===
      autosave = "on_focus_change";

      # === Cursor ===
      cursor_blink = true;
      cursor_shape = "underline";

      # === Diagnostics ===
      diagnostics = {
        inline.enabled = true;
      };

      # === File Finder ===
      file_finder = {
        file_icons = true;
      };

      # === Git ===
      git = {
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = true;
          show_commit_summary = true;
        };
      };

      # === Gutter ===
      gutter = {
        folds = false;
      };

      # === Helix ===
      helix_mode = true;

      # === Indentation ===
      indent_guides = {
        active_line_width = 10;
        background_coloring = "disabled";
        coloring = "indent_aware";
        enabled = true;
        line_width = 2;
      };

      # === Layout & Window ===
      bottom_dock_layout = "right_aligned";
      title_bar = {
        show_menus = false;
        show_sign_in = false;
        show_user_menu = true;
      };
      use_system_window_tabs = true;

      # === Minimaps ===
      minimap = {
        show = "never";
      };

      # === Panels ===
      collaboration_panel = {
        button = false;
      };
      git_panel = {
        dock = "right";
        status_style = "icon";
        tree_view = true;
      };
      outline_panel = {
        auto_fold_dirs = true;
        auto_reveal_entries = true;
        button = true;
        file_icons = true;
        folder_icons = true;
        git_status = true;
      };
      project_panel = {
        default_width = 250;
        entry_spacing = "standard";
        git_status = true;
        hide_root = true;
        indent_size = 12;
      };

      # === Search ===
      search = {
        button = false;
      };

      # === Scroll ===
      scroll_beyond_last_line = "vertical_scroll_margin";
      sticky_scroll = {
        enabled = false;

      };

      # === Status Bar ===
      status_bar = {
        active_language_button = true;
        cursor_position_button = true;
      };

      # === Terminal ===
      terminal = {
        button = false;
      };

      # === Theme ===
      theme = {
        mode = "system";
      };

      # === Tabs ===
      tab_bar = {
        show = true;
        show_nav_history_buttons = false;
        show_tab_bar_buttons = false;
      };
      tabs = {
        file_icons = true;
        git_status = true;
        show_close_button = "hidden";
        show_diagnostics = "all";
      };

      # === Calls ===
      calls = {
        mute_on_join = true;
      };

      # === Languages ===
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "nixd"
          ];
          formatter = {
            external = {
              arguments = [
                "--"
                "--quiet"
              ];
              command = "nixfmt";
            };
          };
        };
      };
    };
  };
}
