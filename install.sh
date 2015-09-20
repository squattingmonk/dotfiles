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

# gtk
mkdir -pv ~/.config/gtk-3.0
ln -sf ${BASEDIR}/gtk/gtkrc-3.0 ~/.config/gtk-3.0/settings.ini
ln -sf ${BASEDIR}/gtk/gtkrc-2.0 ~/.gtkrc-2.0

# sxhkd
mkdir -pv ~/.config/sxhkd
ln -sf ${BASEDIR}/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
ln -sf ${BASEDIR}/sxhkd/sxhkdrc.bspwm ~/.config/sxhkd/sxhkdrc.bspwm

# vim
ln -sf ${BASEDIR}/vim/vimrc ~/.vimrc

mkdir -pv ~/.vim/colors
for file in $(dir ${BASEDIR}/vim/colors); do
    ln -sf ${BASEDIR}/vim/colors/${file} ~/.vim/colors/${file}
done

mkdir -pv ~/.vim/autoload
for file in $(dir ${BASEDIR}/vim/autoload); do
    ln -sf ${BASEDIR}/vim/autoload/${file} ~/.vim/autoload/${file}
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
