#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# killall zscroll

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch all bars using the config location ~/.config/polybar/config.ini

CONFIG_LOCATION=/home/"$USER"/.config/polybar/config.ini
DISPLAY_PRIMARY=$(xrdb -query | grep 'display.primary'| awk '{print $NF}')
DISPLAY_SECONDARY=$(xrdb -query | grep 'display.secondary'| awk '{print $NF}')

for bar in "$HOME"/.config/polybar/bars/*
do
    bar=${bar##*/}
    bar=${bar%%.*}
    if [[ "$bar" == "i3-workspaces" || "$bar" == "polywins" ]]; then
        MONITOR=$DISPLAY_PRIMARY polybar --reload "$bar" -q -c "$CONFIG_LOCATION" &
        MONITOR=$DISPLAY_SECONDARY polybar --reload "$bar" -q -c "$CONFIG_LOCATION" &
    else
        polybar --reload "$bar" -q -c "$CONFIG_LOCATION" &
    fi
done

echo "Polybar launched..."
