{
  nm-wifi-widget,
  sway-keyboard-widget,
  sway-workspaces-widget,
}: ''
(deflisten keyboard-layout :initial "KKK" "${sway-keyboard-widget}/bin/wk")
(defwidget keyboard [] (label :text keyboard-layout))

(deflisten wifi-text :initial "no wifi" "${nm-wifi-widget}/bin/nm-wifi")
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

(defwidget icon []
    (box :class "icon" 
         :halign "center"
          (children)))

;; a button and hidden slider which shows on hover
(defwidget button-and-slider [value label ?onchange ?onclick ?tooltip]
      (box :orientation "h"
           :space-evenly false
           :tooltip tooltip
          (scale :min 0
                 :max 101
                 :orientation "h"
                 :active {onchange != ""}
                 :value value
                 :width 80
                 :onchange onchange)
          (box :visible {!(onclick != "")}
               (icon label))
          (button :onclick onclick
                  :visible {onclick != ""}
                  :timeout "1s"
                    (icon label))))

(defwidget battery []
  (box
    :class {EWW_BATTERY.BAT0.status == "Charging" ? "battery charging": "battery"}
    :space-evenly false
    (button-and-slider 
      :tooltip {EWW_BATTERY.BAT0.capacity}
      :label {EWW_BATTERY.BAT0.status == "Charging" ? 
       (EWW_BATTERY.BAT0.capacity < 10 ? "" : 
        EWW_BATTERY.BAT0.capacity < 20 ? "" : 
        EWW_BATTERY.BAT0.capacity < 30 ? "" : 
        EWW_BATTERY.BAT0.capacity < 40 ? "" : 
        EWW_BATTERY.BAT0.capacity < 50 ? "" : 
        EWW_BATTERY.BAT0.capacity < 60 ? "" : 
        EWW_BATTERY.BAT0.capacity < 70 ? "" : 
        EWW_BATTERY.BAT0.capacity < 80 ? "" : 
        EWW_BATTERY.BAT0.capacity < 90 ? "" : "") :
       (EWW_BATTERY.BAT0.capacity < 10 ? "" : 
        EWW_BATTERY.BAT0.capacity < 20 ? "" : 
        EWW_BATTERY.BAT0.capacity < 30 ? "" : 
        EWW_BATTERY.BAT0.capacity < 40 ? "" : 
        EWW_BATTERY.BAT0.capacity < 50 ? "" : 
        EWW_BATTERY.BAT0.capacity < 60 ? "" : 
        EWW_BATTERY.BAT0.capacity < 70 ? "" : 
        EWW_BATTERY.BAT0.capacity < 80 ? "" : 
        EWW_BATTERY.BAT0.capacity < 90 ? "" : "")
      }
      :value {EWW_BATTERY.BAT0.capacity})))

(defwidget wifi []
    (label
      :xalign 1
      :text wifi-text))

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
    (box
      :orientation "horizontal"
      :halign "left"
      (workspaces))
    (box
      :orientation "horizontal"
      :halign "end"
      (wifi)
      (keyboard)
      (battery)
      (datetime)
      )))
''
