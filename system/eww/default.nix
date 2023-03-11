{ config, pkgs, ... }:

let
# ┌───────────┬──────────────────┬────────────────────────────────────────────┐
# │EVENT TYPE │       NAME       │                DESCRIPTION                 │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000000 │    workspace     │ Sent whenever an event involving a         │
# │           │                  │ workspace occurs such as initialization of │
# │           │                  │ a new workspace or a different workspace   │
# │           │                  │ gains focus                                │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000002 │       mode       │ Sent whenever the binding mode changes     │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000003 │      window      │ Sent whenever an event involving a view    │
# │           │                  │ occurs such as being reparented, focused,  │
# │           │                  │ or closed                                  │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000004 │ barconfig_update │ Sent whenever a bar config changes         │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000005 │     binding      │ Sent when a configured binding is executed │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000006 │     shutdown     │ Sent when the ipc shuts down because sway  │
# │           │                  │ is exiting                                 │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000007 │       tick       │ Sent when an ipc client sends a SEND_TICK  │
# │           │                  │ message                                    │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000014 │ bar_state_update │ Send when the visibility of a bar should   │
# │           │                  │ change due to a modifier                   │
# ├───────────┼──────────────────┼────────────────────────────────────────────┤
# │0x80000015 │      input       │ Sent when something related to input de‐   │
# │           │                  │ vices changes                              │
# └───────────┴──────────────────┴────────────────────────────────────────────┘

  sway-workspaces-widget = pkgs.writeShellScriptBin "wsw" ''
#!/usr/bin/env bash

# Script to LISTEN for workspace updates and generates DTO for eww in JSON:
#
#  I.E. - [{"urgent":false,"name":"1:1","focused":true}]\n
#

jqSelect='[.[] | {name: .name, focused: .focused, urgent: .urgent}]'
printStatus() {
    ${pkgs.sway}/bin/swaymsg -t get_workspaces | ${pkgs.jq}/bin/jq --raw-output --compact-output "$jqSelect"
}
printStatus
${pkgs.sway}/bin/swaymsg -t subscribe -m '[ "workspace" ]' | while read -r _ ; do printStatus; done
  '';

  sway-keyboard-widget = pkgs.writeShellScriptBin "wk" ''
#!/usr/bin/env bash

# TODO: INSTEAD USE THE EVENT payload!!
# also .. think on "tick" event that may send payload .. an overlay BUS..
# TODO: possibly use php instead of bach
printStatus() {
    ${pkgs.sway}/bin/swaymsg -t get_inputs | jq '[.[] | .xkb_active_layout_name][0]'
}
printStatus
${pkgs.sway}/bin/swaymsg -t subscribe -m '[ "input" ]' | while read -r _ ; do printStatus; done
  '';

eww-wrapped = pkgs.symlinkJoin {
  name = "eww-wrapped";
  paths = [ pkgs.eww-wayland ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/eww \
      --add-flags '--config /etc/eww/'
  '';
};

in

{

  config.environment.etc."eww/eww.scss".text = import ./scss.nix {};
  config.environment.etc."eww/eww.yuck".text = import ./yuck.nix {
    inherit
      sway-keyboard-widget
      sway-workspaces-widget;
  };
  config.environment.systemPackages = [ eww-wrapped ];

}
