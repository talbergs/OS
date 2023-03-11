{ config, pkgs, ... }:

let
  terminal-cwd = pkgs.writeShellScriptBin "terminal-cwd" ''
#!/usr/bin/env bash

terminal=".alacritty-wrap"
pid=$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq '.. | select(.type?) | select(.type=="con") | select(.focused==true).pid')
pname=$(ps -p $pid -o comm= | sed 's/-$//')

if [[ $pname == $terminal ]]
then
  ppid=$(pgrep --newest --parent $pid)
  readlink /proc/$ppid/cwd || echo $HOME
else
  echo $HOME
fi
  '';

alacritty-wrapped = pkgs.symlinkJoin {
  name = "alacritty-wrapped";
  paths = [ pkgs.alacritty ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/alacritty \
      --add-flags '--working-directory $(${terminal-cwd}/bin/terminal-cwd)' \
      --add-flags '--config-file /etc/alacritty.yml'
  '';
};

in

{

  config.environment.systemPackages = [
    alacritty-wrapped
  ];

  config.environment.etc."alacritty.yml".source = ./alacritty.yml;

}
