{ pkgs, ... }:
{
  programs = {
    niri = {
      package = pkgs.niri;
      settings = {
        spawn-at-startup = [
          {
            command = [
              "noctalia-shell"
            ];
          }
        ];
        input.keyboard.xkb = {
          layout = "us";
          variant = "colemak";
        };
        outputs = {
          eDP-1.mode = {
            height = 1200;
            width = 1920;
            refresh = 60.003;
          };
          HDMI-A-1.mode = {
            height = 1440;
            width = 2560;
            refresh = 143.999;
          };
        };
        # window-rules = {
        #   geometry-corner-radius = 20;
        #   clip-to-geometry = true;
        # };
        layout = {
          gaps = 16;
        };
        hotkey-overlay.skip-at-startup = true;
        binds =
        let
          spawnLocked = command: {
            action.spawn = command;
            allow-when-locked = true;
          };
          noRepeat = {
            repeat = false;
          };
        in
        {
          "Mod+Space".action.spawn-sh = "noctalia-shell ipc call launcher toggle";
          "Mod+S".action.spawn-sh = "noctalia-shell ipc call controlCenter toggle";
          "Mod+Shift+G".action.spawn-sh = "noctalia-shell ipc call lockScreen lock";
          "Mod+Q" = ( noRepeat // { action.close-window = []; });
          "Mod+O" = ( noRepeat // { action.toggle-overview = []; });
          "Mod+H".action.focus-column-left = [];
          "Mod+J".action.focus-window-down = [];
          "Mod+K".action.focus-window-up = [];
          "Mod+L".action.focus-column-right = [];
          "Mod+Left".action.focus-column-left = [];
          "Mod+Down".action.focus-window-down = [];
          "Mod+Up".action.focus-window-up = [];
          "Mod+Right".action.focus-column-right = [];
          "Mod+WheelScrollRight".action.focus-column-right = [];
          "Mod+WheelScrollLeft".action.focus-column-left = [];
          "Mod+Shift+H".action.move-column-left = [];
          "Mod+Shift+J".action.move-window-down = [];
          "Mod+Shift+K".action.move-window-up = [];
          "Mod+Shift+L".action.move-column-right = [];
          "Mod+R".action.switch-preset-column-width = [];
          "Mod+Shift+R".action.switch-preset-window-height = [];
          "Mod+Ctrl+R".action.reset-window-height = [];
          "Mod+F".action.maximize-column = [];
          "Mod+V".action.toggle-window-floating = [];
          "XF86AudioRaiseVolume" = (spawnLocked [ "noctalia-shell" "ipc" "call" "volume" "increase" ]);
          "XF86AudioLowerVolume" = (spawnLocked [ "noctalia-shell" "ipc" "call" "volume" "decrease" ]);
          "XF86AudioPlay" = (spawnLocked [ "noctalia-shell" "ipc" "call" "media" "playPause" ]);
          "XF86AudioNext" = (spawnLocked [ "noctalia-shell" "ipc" "call" "media" "next" ]);
          "XF86AudioPrev" = (spawnLocked [ "noctalia-shell" "ipc" "call" "media" "previous" ]);
          "XF86AudioMute" = (spawnLocked [ "noctalia-shell" "ipc" "call" "volume" "muteOutput" ]);
          "XF86AudioMicMute" = (spawnLocked [ "noctalia-shell" "ipc" "call" "volume" "muteInput" ]);
          "XF86MonBrightnessUp" = (spawnLocked [ "noctalia-shell" "ipc" "call" "brightness" "increase" ]);
          "XF86MonBrightnessDown" = (spawnLocked [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ]);
        };
      };
    };
  };
}
