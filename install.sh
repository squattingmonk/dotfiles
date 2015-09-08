#!/bin/bash
LINKOPTIONS="sf"
BASEDIR=$(pwd)

# git
ln -sf ${BASEDIR}/git/gitconfig ~/.gitconfig

# bin
#ln -s ${BASEDIR}/bin ~/.bin

# bspwm
mkdir -pv ~/.config/bspwm
ln -sf ${BASEDIR}/bspwm/bspwmrc ~/.config/bspwm/bspwmrc

# sxhkd
mkdir -pv ~/.config/sxhkd
ln -sf ${BASEDIR}/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc

# vim
ln -sf ${BASEDIR}/vim/vimrc ~/.vimrc

mkdir -pv ~/.vim/colors
for file in ${BASEDIR}/vim/colors/{.,}*; do
    ln -${LINKOPTIONS} ${file} ~/.vim/colors/$(basename ${file})
done

# X11
ln -sf ${BASEDIR}/X11/xinitrc ~/.xinitrc
ln -sf ${BASEDIR}/X11/Xresources ~/.Xresources
