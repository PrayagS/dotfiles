#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 30 \
        --delay 0.1 \
        --scroll-padding "  " \
        --match-command "$HOME/.config/polybar/scripts/get_playerctl_status.sh" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true '/home/prayag_s/.config/polybar/scripts/get_spotify_status.sh' &

wait
