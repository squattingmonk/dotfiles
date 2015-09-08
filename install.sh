#!/bin/bash
BASEDIR=$(dirname $(readlink -f $0))

# git
ln -sf ${BASEDIR}/git/gitconfig ~/.gitconfig

# bin
mkdir -pv ~/.bin
for file in $(dir ${BASEDIR}/bin); do
    ln -s ${BASEDIR}/bin/${file} ~/.bin/${file}
done

# bspwm
mkdir -pv ~/.config/bspwm
ln -s ${BASEDIR}/bspwm/bspwmrc ~/.config/bspwm/bspwmrc

# sxhkd
mkdir -pv ~/.config/sxhkd
ln -s ${BASEDIR}/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc

# vim
ln -sf ${BASEDIR}/vim/vimrc ~/.vimrc

mkdir -pv ~/.vim/colors
for file in ${BASEDIR}/vim/colors/{.,}*; do
    ln -s ${file} ~/.vim/colors/$(basename ${file})
done

# X11
ln -sf ${BASEDIR}/X11/xinitrc ~/.xinitrc
ln -sf ${BASEDIR}/X11/Xresources ~/.Xresources
