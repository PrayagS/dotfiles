#!/bin/sh

# Terminate already running bar instances
killall -q polybar
killall zscroll

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch all bars using the config location ~/.config/polybar/config.ini
for bar in $HOME/.config/polybar/bars/*
do
  bar=${bar##*/}
  bar=${bar%%.*}
  polybar $bar -c /home/$USER/.config/polybar/config.ini &
done

echo "Polybar launched..."
