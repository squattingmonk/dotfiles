#!/bin/bash

BASEDIR=$(pwd)

# git
ln -s ${BASEDIR}/git/gitconfig ~/.gitconfig

# bin
ln -s ${BASEDIR}/bin ~/.bin

# bspwm
mkdir -pv ~/.config/bspwm
ln -s ${BASEDIR}/bspwm/bspwmrc ~/.config/bspwm/bspwmrc

# sxhkd
mkdir -pv ~/.config/sxhkd
ln -s ${BASEDIR}/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc

# vim
mkdir -pv ~/.vim
ln -s ${BASEDIR}/vim/vimrc ~/.vimrc

# X11
ln -s ${BASEDIR}/X11/xinitrc ~/.xinitrc
ln -s ${BASEDIR}/X11/Xresources ~/.Xresources
