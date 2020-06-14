#!/usr/bin/env sh

# Path
export PATH=/usr/local/texlive/2020/bin/x86_64-linux:$PATH
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/bin:$PATH

# Defaults
export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR="nvim"
export PAGER="less"
export TERMINAL="st"
export BROWSER="google-chrome-stable"
export LOLCOMMITS_DEVICE=/dev/video0

# Source zshrc
echo "$0" | grep "zsh$" >/dev/null && [ -f ~/.zshrc ] && source "~/.zshrc"

# Caps Lock => Escape
setxkbmap -option caps:escape &

# Start compton
compton -b &

# Set wallpaper and wal theme
wal -i ~/Pictures/Wallpapers -o "wal-set"

# Start hotkey daemon
sxhkd &

# Start redshift
redshift -l 23.022505:72.571365 &

# Change trackpad defaults
natural-scroll-and-tap

# Start power manager to manage suspend and sleep
xfce4-power-manager &

# Setup lock on suspend and lid close
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- lock.sh &

# NetworkManager applet
nm-applet &
