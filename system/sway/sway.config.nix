_: ''
set $mod Mod4
set $alt Mod1

bindsym $mod+Return exec alacritty
bindsym $mod+w exec chromium
bindsym Control+space exec makoctl dismiss

set $menu fuzzel
bindsym $mod+d exec $menu

# seat seat0 xcursor_theme Borealis-cursors 48

input * {
    pointer_accel 0.35
    repeat_delay 275
    repeat_rate 50
    # additional escape
    tap enabled
    natural_scroll enabled
    scroll_method two_finger
    # disable while typing
    dwt enabled
}

input "type:keyboard" {
    xkb_layout "us,lv(apostrophe)"
    xkb_options "grp:rctrl_toggle,caps:escape"
}

bindsym $mod+Shift+q kill
bindsym $mod+Shift+c reload
bindsym $mod+b splith
bindsym $mod+v splitv

bindsym $mod+Tab workspace back_and_forth

set $ws1 1
set $ws2 2
set $ws3 3
set $ws4 4
set $ws5 5
set $ws6 6
set $ws7 7
set $ws8 8
set $ws9 9
set $ws0 10

# switch to workspace {{{1
bindsym $mod+1   workspace $ws1
bindsym $mod+2   workspace $ws2
bindsym $mod+3   workspace $ws3
bindsym $mod+4   workspace $ws4
bindsym $mod+5   workspace $ws5
bindsym $mod+6   workspace $ws6
bindsym $mod+7   workspace $ws7
bindsym $mod+8   workspace $ws8
bindsym $mod+9   workspace $ws9
bindsym $mod+0   workspace $ws0

# move focused container to workspace
bindsym $mod+Shift+1    move container to workspace $ws1
bindsym $mod+Shift+2    move container to workspace $ws2
bindsym $mod+Shift+3    move container to workspace $ws3
bindsym $mod+Shift+4    move container to workspace $ws4
bindsym $mod+Shift+5    move container to workspace $ws5
bindsym $mod+Shift+6    move container to workspace $ws6
bindsym $mod+Shift+7    move container to workspace $ws7
bindsym $mod+Shift+8    move container to workspace $ws8
bindsym $mod+Shift+9    move container to workspace $ws9
bindsym $mod+Shift+0    move container to workspace $ws0

bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

bindsym $mod+f fullscreen
# Toggle the current focus between tiling and floating mode
bindsym $mod+Shift+space floating toggle
# Swap focus between the tiling area and the floating area
bindsym $mod+space focus mode_toggle
bindsym $mod+o sticky toggle
floating_modifier $mod
workspace_auto_back_and_forth yes

bindsym $mod+Control+h resize shrink width 30px
bindsym $mod+Control+j resize shrink height 30px
bindsym $mod+Control+k resize grow height 30px
bindsym $mod+Control+l resize grow width 30px

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right


# below the official single line would remove title bars
default_border none

default_floating_border none
# font pango:monospace 1
# titlebar_padding 1
titlebar_border_thickness 0

set $mode_system System: (l) lock, (e) logout, (s) suspend, (r) reboot, (S) shutdown, (R) UEFI
mode "$mode_system" {
    bindsym l exec $lock, mode "default"
    bindsym e exit
    bindsym s exec --no-startup-id $lock && systemctl suspend, mode "default"
    bindsym r exec --no-startup-id systemctl reboot, mode "default"
    bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"
    bindsym Shift+r exec --no-startup-id systemctl reboot --firmware-setup, mode "default"

    # return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+Shift+Return mode "$mode_system"

exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
''
