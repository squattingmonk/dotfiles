#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Change the wallpaper with feh
#feh --bg-scale $HOME/Pictures/dwm.png &
source $HOME/.fehbg

# Hide the cursor after one second of inactivity
unclutter -root -idle 1 &

# Start our compositor
xcompmgr -c &

# Load our X resources
xrdb -load .Xresources

# Start terminal daemon
urxvtd &

# Start our keybind daemon
sxhkd &

# Launch dwm
exec $HOME/.bin/dwm-start
