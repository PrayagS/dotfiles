#!/usr/bin/env sh

# Launch dbus interface
dbus-launch --autolaunch=$(cat /var/lib/dbus/machine-id) --sh-syntax --exit-with-session

# Start gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Caps Lock => Escape
setxkbmap -option caps:escape &

# Start ibus for multiple kb inputs
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx --panel /usr/lib/ibus/ibus-ui-gtk3

# Path
export PATH=$HOME/bin:$PATH

# Setup display
setup-display

# Start picom (the compositor)
picom --experimental-backends -b &

# Set wallpaper and wal theme
wal -i ~/Pictures/Wallpapers --recursive -o "wal-set"

# Setup lock on suspend and lid close
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- lock.sh &

# Start hotkey daemon
sxhkd &

# Start redshift
redshift &

# Start power manager to manage suspend and sleep
xfce4-power-manager &

# Optimus Manager Qt (tray applet for optimus manager)
optimus-manager-qt &

# Pulseaudio systray
pasystray --include-monitors &

# Generate index for bolt
bolt --generate --watch &

# reload dunst
xrdb -merge ~/.Xresources
~/.config/dunst/wal.sh

# Change trackpad defaults
natural-scroll-and-tap

