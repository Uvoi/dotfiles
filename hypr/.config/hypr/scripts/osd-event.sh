#!/bin/bash

# Event-driven OSD helper. It runs only when a keybind or udev event calls it.
set -u

event="${1:-}"

case "$event" in
    layout)
        # Let the non-consuming keybind reach XKB before reading the new state.
        sleep 0.08
        layout=$(hyprctl devices -j | jq -r '[.keyboards[] | select(.main == true) | .active_keymap][0] // "Неизвестно"')

        case "$layout" in
            *English*) label="EN" ;;
            *Russian*) label="RU" ;;
            *) label="$layout" ;;
        esac

        notify-send -e -r 9101 -a lang -u low -t 700 "$label"
        ;;

    caps)
        # Caps Lock is passed through to the focused client; read its state after it toggles.
        sleep 0.08
        state=$(hyprctl devices -j | jq -r '[.keyboards[] | select(.main == true) | .capsLock][0] // false')

        if [[ "$state" == "true" ]]; then
            notify-send -e -r 9102 -a caps -u low -t 700 "CAPS"
        else
            notify-send -e -r 9102 -a caps -u low -t 700 "caps"
        fi
        ;;

    power)
        state="${2:-}"
        if [[ "$state" == "1" ]]; then
            notify-send -e -r 9103 -a osd -u low -t 1000 "󰚥"
        elif [[ "$state" == "0" ]]; then
            notify-send -e -r 9103 -a osd -u low -t 1000 "󰁹"
        fi
        ;;
esac
