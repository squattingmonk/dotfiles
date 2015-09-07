#!/bin/bash

BASEDIR="~/.dotfiles"

# git
ln -s ${BASEDIR}/git/gitconfig ~/.gitconfig

# bin
ln -s ${BASEDIR}/bin/ ~/bin/

# bspwm
ln -s ${BASEDIR}/bspwm/bspwmrc ~/.config/bspwm/bspwmrc

# sxhkd
ln -s ${BASEDIR}/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc

# X11
ln -s ${BASEDIR}/X11/xinitrc ~/.xinitrc
ln -s ${BASEDIR}/X11/Xdefaults ~/.Xdefaults
