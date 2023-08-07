pkgs:
let
  amixer = "${pkgs.amixer}/bin/amixer";
in
pkgs.writeShellScriptBin "toggle-mic" ''
  #!/bin/bash

  if [[ -z $(${amixer} get Capture | ag --literal "[off]") ]];then
      off=1
  else
      off=
  fi

  if [[ $1 == toggle ]];then

      # amixer set Capture toggle
      # This way all sources are muted.
      if [[ -z $(${amixer} get Capture | ag --literal "[off]") ]];then
          pactl list short sources | awk '/input.*RUNNING/ {system("pactl set-source-mute " $1 " on")}'
      else
          pactl list short sources | awk '/input.*RUNNING/ {system("pactl set-source-mute " $1 " off")}'
      fi

      pkill -SIGRTMIN+9 waybar
      exit 0
  fi

  if [[ $off ]];then
      echo '{ "text": ""}'
  else
      echo '{ "text": "" }'
  fi
''
