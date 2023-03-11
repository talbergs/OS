{ config, pkgs, ... }:

let
# More https://www.ertt.ca/nix/shell-scripts/
  fkill = pkgs.writeShellScriptBin "fkill" ''
#!/bin/bash
#|
#| [f]uzzy [kill] match and kill a process(es)
#|
#| will send SIGINT9 by default
#| - use tab to multiselect
#| - use ctrl-a to send sigint to all list
#|
#| Usage: fkill [query?]
#|
[[ $1 == -h ]] && grep '^#|' $0 | sed 's/^#//' && exit

pid=$(
    ps -ef\
    | sed 1d\
)
pid=$(
    echo "$pid"\
    | grep --invert-match "$0"\
    | ${pkgs.fzf}/bin/fzf -m --bind 'ctrl-a:select-all+accept' --query "$1"\
    |  awk '{print $2}'\
)

if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -9
fi
  '';
in

{
  config.environment.systemPackages = [ fkill ];
}
