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

setxkbmap -option caps:escape & # Caps Lock => Escape
compton -b & # Start compton
wal -i ~/Pictures/Wallpapers -o "wal-set" # Set wallpaper and wal theme
sxhkd & # Start hotkey daemon
redshift -l 23.022505:72.571365 & # Start redshift
natural-scroll-and-tap # Change trackpad defaults
xfce4-power-manager & # Start power manager to manage suspend and sleep
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- lock.sh & # Setup lock on suspend and lid close
nm-applet & # NetworkManager applet
