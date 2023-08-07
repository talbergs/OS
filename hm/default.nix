pkgs: (import ./modules pkgs) ++
[
  ./git.nix
  ./alacritty.nix
  ./sway.nix
  ./mpv.nix
  ./mime.nix
  ./eww.nix
  {
    # home.packages = [ pkgs.syncthing ];
    services.syncthing.enable = true;
  }
  {
    home.packages = [

      (
        pkgs.writeShellScriptBin "toggle-mute-mic" ''
          #!/bin/bash

          if [[ -z $(amixer get Capture | ag --literal "[off]") ]];then
              off=1
          else
              off=
          fi

          if [[ $1 == toggle ]];then

              # amixer set Capture toggle
              # This way all sources are muted.
              if [[ -z $(amixer get Capture | ag --literal "[off]") ]];then
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
      )

      (
        pkgs.writeShellScriptBin "keyboard-layout" ''
          #!/bin/bash
          if [[ -z $(swaymsg -t get_inputs | ag apostrophe) ]];then
              cur=en
          else
              cur=lv
          fi

          if [[ $1 == next ]];then
              if [[ $cur == lv ]];then
                  swaymsg input "*" xkb_layout "us"
              else
                  swaymsg input "*" xkb_layout "lv(apostrophe)"
              fi
              pkill -SIGRTMIN+8 waybar
              exit 0
          fi

          if [[ $cur == lv ]];then
              echo '{ "text": "lv", "class": "lv"}'
          else
              echo '{ "text": "en" }'
          fi


          # echo -n $cur
        ''
      )

      (
        pkgs.writeShellScriptBin "screenrec" ''
          #!/bin/bash
          # @dotdep slurp wf-recorder

          pidf=/tmp/$(basename $0).pid

          if [ $1 == --waybar ];then
            if [ -e $pidf ]; then
                echo '{ "text": "•" }'
            else
                echo '{ "text": "" }'
            fi

            exit 0
          fi

          if [ -e $pidf ]; then
            kill -SIGINT $(sed -n '1p' $pidf)
            name=$(sed -n '2p' $pidf)
            rm $pidf

            pkill -SIGRTMIN+9 waybar
            wl-copy < $name
            notify-send "Rec: $name"
          else
            touch $pidf
            pkill -SIGRTMIN+9 waybar
            sel="$(slurp)"

            if [ $? -ne "0" ];then
              rm $pidf
              pkill -SIGRTMIN+9 waybar
              exit 0
            fi

            dir=~/Videos/screenrec
            mkdir -p $dir 2> /dev/null
            name="$dir/$(date +"%Y-%m-%d_%H-%M-%S").mp4"

            wf-recorder -g "$sel" -f $name &
            echo $! > $pidf
            echo $name >> $pidf
          fi
        ''
      )

      (
        pkgs.writeShellScriptBin "aws-widget-sso" ''
        #!/bin/bash

        # UTF-8 drawing chars: ┊,⋮,•,⋮,·,
        waybar-refresh() {
            pkill -SIGRTMIN+10 waybar
        }

        sso-has-session() {
            php $HOME/.scripts-vendor/aws-sso-widget/has_sso_session.php
        }

        widget-json() {
            php $HOME/.scripts-vendor/aws-sso-widget/status.php
        }

        get-menu-pick() {
            echo $(php $HOME/.scripts-vendor/aws-sso-widget/menu_preview.php $1)
        }

        set-menu-pick() {
            php $HOME/.scripts-vendor/aws-sso-widget/set_menu_csv_idx.php $1
        }

        load-menu-csv() {
            php $HOME/.scripts-vendor/aws-sso-widget/menu_csv.php
        }

        case "$1" in
            text)
                echo $(widget-json)
            ;;
            click)
                sso-has-session || notify-send "  No SSO session." "Opening browser to login.."
                sso-has-session || (aws sso login && waybar-refresh)
                pickIndex=$(load-menu-csv | column -t -s ',' -o ' · ' | fuzzel --dmenu --lines 7 --width 80 --index)
                notify-send $pickIndex "$(get-menu-pick $pickIndex)"
                (( $? == 0 )) && set-menu-pick $pickIndex
                waybar-refresh
            ;;
            *) echo '{"text": "ERROR! Usage: $0 text|click"}' ;;
        esac
        ''
      )

      (
        pkgs.writeShellScriptBin "vpn" ''
          #!/bin/bash

          if [ $1 == --waybar ];then
              if [ ! -z "$(ip addr | ag ppp0)" ]; then
                echo '{ "text": "vpn" }'
            else
                echo '{ "text": "" }'
            fi

            exit 0
          fi
        ''
      )
    ];
  }
]
