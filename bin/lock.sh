#!/bin/sh

# take screenshot
# import -window root /tmp/screenshot.png

# blur it
# convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
# rm /tmp/screenshot.png

xsecurelock_method(){
   export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 
   export XSECURELOCK_FONT='JetBrainsMono Nerd Font'
   export XSECURELOCK_SHOW_DATETIME=1 
   export XSECURELOCK_SHOW_HOSTNAME=2 
   export XSECURELOCK_SHOW_USERNAME=1 
   export XSECURELOCK_LIST_VIDEOS_COMMAND='cat ~/.cache/wal/wal'
   export XSECURELOCK_SAVER=saver_mpv 
   xsecurelock 
}

xsecurelock_method
