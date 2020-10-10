#!/bin/bash

STATUS=$($HOME/.config/polybar/scripts/get_playerctl_status.sh)

if [ "$STATUS" = "Stopped" ]; then
    echo "No music is playing"
elif [ "$STATUS" = "Paused"  ]; then
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook spotify-play-pause 2 1>/dev/null 2>&1
    playerctl --player=playerctld metadata --format "{{ title }} - {{ artist }}"
elif [ "$STATUS" = "No player is running"  ]; then
    echo $STATUS
else
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook spotify-play-pause 1 1>/dev/null 2>&1
    playerctl --player=playerctld metadata --format "{{ title }} - {{ artist }}"
fi
