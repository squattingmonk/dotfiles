#!/bin/bash

BASEDIR=$(pwd)

# git
ln -s ${BASEDIR}/git/gitconfig ~/.gitconfig

# bin
ln -s ${BASEDIR}/bin ~/.bin

# bspwm
ln -s ${BASEDIR}/bspwm/bspwmrc ~/.config/bspwm/bspwmrc

# sxhkd
ln -s ${BASEDIR}/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc

# vim
ln -s ${BASEDIR}/vim/vimrc ~/.vimrc

# X11
ln -s ${BASEDIR}/X11/xinitrc ~/.xinitrc
ln -s ${BASEDIR}/X11/Xresources ~/.Xresources
