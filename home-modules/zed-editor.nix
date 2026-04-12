{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [ ];
    extraPackages = [ pkgs.nixd ];
    userSettings = {
      edit_predictions.mode = "eager";
      agent = {
        play_sound_when_agent_done = true;
      };
      calls.mute_on_join = true;
      git = {
        inline_blame = {
          enabled = true;
          show_commit_summary = true;
        };
        git_gutter = "tracked_files";
      };
      collaboration_panel.button = false;
      notification_panel.button = false;
      outline_panel = {
        auto_reveal_entries = true;
        auto_fold_dirs = true;
        git_status = true;
        folder_icons = true;
        file_icons = true;
        button = true;
      };
      use_system_window_tabs = true;
      bottom_dock_layout = "right_aligned";
      tabs = {
        show_close_button = "hidden";
        show_diagnostics = "all";
        file_icons = true;
        git_status = true;
      };
      tab_bar = {
        show = true;
        show_tab_bar_buttons = false;
        show_nav_history_buttons = false;
      };
      title_bar = {
        show_menus = false;
        show_user_menu = true;
        show_sign_in = false;
        show_branch_icon = true;
      };
      search.button = false;
      status_bar = {
        cursor_position_button = true;
        active_language_button = true;
      };
      project_panel = {
        hide_root = true;
        indent_size = 12;
        git_status = true;
        entry_spacing = "standard";
        default_width = 250;
      };
      file_finder.file_icons = true;
      diagnostics.inline.enabled = true;
      indent_guides = {
        active_line_width = 10;
        line_width = 2;
        background_coloring = "disabled";
        coloring = "indent_aware";
        enabled = true;
      };
      minimap.show = "never";
      gutter.folds = false;
      sticky_scroll.enabled = false;
      scroll_beyond_last_line = "vertical_scroll_margin";
      autosave = "on_focus_change";
      base_keymap = "VSCode";
      cursor_shape = "underline";
      cursor_blink = true;
      git_panel = {
        status_style = "icon";
        tree_view = true;
        dock = "right";
      };
      terminal.button = false;
      helix_mode = true;
      theme.mode = "system";
    };
  };
}
