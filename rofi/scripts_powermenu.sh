#!/bin/bash

rofi_command="rofi "

### Options ###
power_off=" power off"
reboot=" reboot"
lock=" lock"
suspend="鈴 suspend"
log_out=" logout"
# Variable passed to rofi
options="$power_off\n$reboot\n$lock\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -p "Power Menu" -selected-row 2)"
case $chosen in
    $power_off)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        lock.sh
        ;;
    $suspend)
        lock.sh && systemctl suspend
        ;;
    $log_out)
        i3-msg exit
        ;;
esac
