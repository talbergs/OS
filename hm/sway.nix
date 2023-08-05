{ myPkgs, ... }:
let
  sysMode = ''System: (l) lock, (e) logout, (s) suspend, (r) reboot, (S) shutdown, (R) UEFI'';
  wsBinds = builtins.foldl' (x: y: x // y) {} (builtins.map(ws: {
    "Mod4+${ws}" = "workspace ${ws}";
    "Mod4+Shift+${ws}" = "move container to workspace ${ws}";
  }) (builtins.genList builtins.toString 10));
  arrowBinds = builtins.foldl' (x: y: x // y) {} (builtins.map({left, right, down, up}: {
      "Mod4+${left}" = "focus left";
      "Mod4+${down}" = "focus down";
      "Mod4+${up}" = "focus up";
      "Mod4+${right}" = "focus right";
      "Mod4+Control+${left}" = "resize shrink width 30px";
      "Mod4+Control+${down}" = "resize shrink height 30px";
      "Mod4+Control+${up}" = "resize grow height 30px";
      "Mod4+Control+${right}" = "resize grow width 30px";
      "Mod4+Shift+${left}" = "move left";
      "Mod4+Shift+${down}" = "move down";
      "Mod4+Shift+${up}" = "move up";
      "Mod4+Shift+${right}" = "move right";
  }) [{left="h";right="l";down="j";up="k";} {left="Left";right="Right";down="Down";up="Up";}]);
in {
  wayland.windowManager.sway = {
    enable = true;
    config = {
      defaultWorkspace = "workspace number 1";
      floating.modifier = "Mod4";
      workspaceAutoBackAndForth = true;
      window = {
        commands = [
          {
            command = "floating enable;resize set 50ppt 50ppt";
            criteria = {
              app_id = "mpv";
            };
          }
        ];
      };
      seat = {
        "*" = {
          hide_cursor = "when-typing enable";
        };
      };
      modes = {
        ${sysMode} = {
          "l" = ''$lock, mode "default'';
          "e" = "exit";
          "s" = ''exec --no-startup-id $lock && systemctl suspend, mode "default'';
          "r" = ''exec --no-startup-id systemctl reboot, mode "default"'';
          "Shift+s" = ''exec --no-startup-id systemctl poweroff -i, mode "default"'';
          "Shift+r" = ''exec --no-startup-id systemctl reboot --firmware-setup, mode "default"'';
          "Return" = ''mode "default"'';
          "Escape" = ''mode "default"'';
        };
      };
      # track the terminal CWD and spawn based on that.
      keybindings = wsBinds // arrowBinds // {
        "Mod4+Return" = ''exec alacritty --working-directory=$(${myPkgs.sway-alacritty-cwd}/bin/main)'';
        "Mod4+Shift+Return" = ''mode "${sysMode}"'';
        "Mod4+w" = "exec chromium";
        "Mod4+d" = "exec fuzzel";
        "Mod4+b" = "splith";
        "Mod4+v" = "splitv";
        "Mod4+Tab" = "workspace back_and_forth";
        "Mod4+f" = "fullscreen";
        "Mod4+Shift+space" = "floating toggle";
        "Mod4+space" = "focus mode_toggle";
        "Mod4+o" = "sticky toggle";
        "Mod4+Shift+q" = "kill";
        "Control+Space" = "exec makoctl dismiss";
      };
      input = {
        "*" = {
          pointer_accel = "0.35";
          repeat_delay = "275";
          repeat_rate = "50";
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_method = "two_finger";
          dwt = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us,lv(apostrophe)";
          xkb_options = "grp:rctrl_toggle,caps:escape";
        };
      };
    };
  };
}
