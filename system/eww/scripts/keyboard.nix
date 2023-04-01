{pkgs}: pkgs.writeShellScriptBin "wk" ''
#!/usr/bin/env bash

# TODO: INSTEAD USE THE EVENT payload!!
# also .. think on "tick" event that may send payload .. an overlay BUS..
# TODO: possibly use php instead of bach
printStatus() {
    ${pkgs.sway}/bin/swaymsg -t get_inputs | jq '[.[] | .xkb_active_layout_name][0]'
}
printStatus
${pkgs.sway}/bin/swaymsg -t subscribe -m '[ "input" ]' | while read -r _ ; do printStatus; done
''
