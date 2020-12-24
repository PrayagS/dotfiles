#!/bin/bash

# Terminate already running bar instances
killall -q polybar
killall zscroll

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch all bars using the config location ~/.config/polybar/config.ini
MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)
TRAY_OUTPUT=eDP-1-1
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    for bar in "$HOME"/.config/polybar/bars/*
    do
        bar=${bar##*/}
        bar=${bar%%.*}
        if [[ "$bar" == "tray" ]]; then
            echo "HERE"
            MONITOR=$TRAY_OUTPUT polybar --reload "$bar" -c /home/"$USER"/.config/polybar/config.ini &
        else
            MONITOR=$m polybar --reload "$bar" -c /home/"$USER"/.config/polybar/config.ini &
        fi
    done
done

echo "Polybar launched..."
