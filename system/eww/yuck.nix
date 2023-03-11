{
  sway-keyboard-widget,
  sway-workspaces-widget,
}: ''
(deflisten keyboard-layout :initial "KKK" "${sway-keyboard-widget}/bin/wk")
(defwidget keyboard [] (label :text keyboard-layout))

(deflisten workspaces :initial "[]" "${sway-workspaces-widget}/bin/wsw")
(defpoll datetime
  :interval "1s"
  "date +'%H:%M:%S'")

(defwidget workspaces []
  (box :class "workspaces"
      :orientation "h"
      :space-evenly true
      :halign "start"
      :spacing 10
    (for ws in workspaces
        (button
            :class "''${ws.focused ? "active" : ws.urgent ? "urgent" : ""}"
            :onclick "swaymsg workspace ''${ws.name}"
            "''${ws.name}"))))

(defpoll battery-capacity :interval "1s" "echo $EWW_BATTERY")

(defwidget battery []
  (box :orientation "v"
    (label :class "bat" 
      :text "''${EWW_BATTERY}")))


(defwidget datetime []
    (label
      :xalign 1
      :text datetime))

(defwindow bar
    :monitor 0
    :geometry (geometry
      :x "0%"
      :y "0%"
      :width "100%"
      :height "32px"
      :anchor "top center")
    :stacking "fg"
    :exclusive true
  (box
    (workspaces)
    (keyboard)
    (battery)
    (datetime)))
''
