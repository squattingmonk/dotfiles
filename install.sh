#!/bin/bash
BASEDIR=$(dirname $(readlink -f $0))

# bash
ln -sf ${BASEDIR}/bash/bashrc ~/.bashrc
ln -sf ${BASEDIR}/bash/bash_profile ~/.bash_profile

# bin
mkdir -pv ~/.bin
for file in $(dir ${BASEDIR}/bin); do
    ln -sf ${BASEDIR}/bin/${file} ~/.bin/${file}
done

# bspwm
mkdir -pv ~/.config/bspwm
ln -sf ${BASEDIR}/bspwm/bspwmrc ~/.config/bspwm/bspwmrc

# fish
mkdir -pv ~/.config/fish
ln -sf ${BASEDIR}/fish/config.fish ~/.config/fish/config.fish

# git
ln -sf ${BASEDIR}/git/gitconfig ~/.gitconfig

# sxhkd
mkdir -pv ~/.config/sxhkd
ln -sf ${BASEDIR}/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc

# vim
ln -sf ${BASEDIR}/vim/vimrc ~/.vimrc

mkdir -pv ~/.vim/colors
for file in $(dir ${BASEDIR}/vim/colors); do
    ln -sf ${BASEDIR}/vim/colors/${file} ~/.vim/colors/${file}
done

# X11
ln -sf ${BASEDIR}/X11/xinitrc ~/.xinitrc
ln -sf ${BASEDIR}/X11/Xresources ~/.Xresources
xrdb merge ~/.Xresources

if [ $(basename ${SHELL}) = "fish" ]; then
    echo "Execute 'source ~/.config/fish/config.fish' to reload fish configuration."
else
    echo "Execute 'source ~/.bashrc' to reload bash configuration."
fi
