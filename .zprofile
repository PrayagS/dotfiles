#!/usr/bin/env sh

# Launch dbus interface
dbus-launch --autolaunch=$(cat /var/lib/dbus/machine-id) --sh-syntax --exit-with-session

# Start gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Path
export PATH=/usr/local/texlive/2020/bin/x86_64-linux:$PATH
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.npm-global/bin:$PATH

# Defaults
export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR="nvim"
export PAGER="less"
export TERMINAL="st"
export BROWSER="google-chrome-stable"
export LOLCOMMITS_DEVICE=/dev/video0
export FORGIT_FZF_DEFAULT_OPTS="
--exact
--border
--cycle
--reverse
--height '80%'
"

# Caps Lock => Escape
setxkbmap -option caps:escape &

# Start ibus for multiple kb inputs
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx --panel /usr/lib/ibus/ibus-ui-gtk3

# Start picom (the compositor)
picom --experimental-backends -b &

# Set wallpaper and wal theme
wal -i ~/Pictures/Wallpapers -o "wal-set"

# Start hotkey daemon
sxhkd &

# Start redshift
redshift &

# Change trackpad defaults
natural-scroll-and-tap

# Start power manager to manage suspend and sleep
xfce4-power-manager &

# Setup lock on suspend and lid close
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- lock.sh &

# NetworkManager applet
nm-applet &

# Optimus Manager Qt (tray applet for optimus manager)
optimus-manager-qt &
