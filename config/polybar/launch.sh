#!/bin/bash

# Terminate already running bar instances
killall -q polybar
killall zscroll

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch all bars using the config location ~/.config/polybar/config.ini
CONFIG_LOCATION=/home/"$USER"/.config/polybar/config.ini
for bar in "$HOME"/.config/polybar/bars/*
do
    bar=${bar##*/}
    bar=${bar%%.*}
    if [[ "$bar" == "i3-workspaces" || "$bar" == "polywins" ]]; then
        for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
            MONITOR=$m polybar --reload "$bar" -c "$CONFIG_LOCATION" &
        done
    else
        polybar --reload "$bar" -c "$CONFIG_LOCATION" &
    fi
done

echo "Polybar launched..."
