{ pkgs, ... }:

let
  swaymsg = "${pkgs.sway}/bin/swaymsg";
  jq = "${pkgs.jq}/bin/jq";
  pgrep = "${pkgs.procps}/bin/pgrep";
in

pkgs.writeShellScriptBin "main" ''
pid=$(${swaymsg} -t get_tree | ${jq} '.. | select(.type?) | select(.type=="con") | select(.focused==true).pid')
command=$(cat /proc/$pid/comm)

if [[ $command == alacritty ]]
then
  ppid=$(${pgrep} -n -P $pid)
  readlink /proc/$ppid/cwd || echo $HOME
else
  echo $HOME
fi
''
