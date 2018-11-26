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

# Load our X resources
xrdb -load ~/.Xresources

# Make caps-lock useful
setxkbmap -option caps:escape

# Turn num lock on by default
numlockx

# Make our cursor nice and pretty
xsetroot -cursor_name left_ptr &

# Set our background wallpaper
source ~/.fehbg &

# Start our compositor
compton -b

# Start a terminal
urxvtd -q -f -o
urxvtc &

# Start our window manager
exec bspwm
