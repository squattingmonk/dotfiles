#!/usr/bin/fish

# Disable the greeting
set fish_greeting

# Source all files in /etc/profile.d
env -i HOME=$HOME dash -l -c 'export -p' | sed -e "/PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

# Set our path
set -U fish_user_paths $HOME/.bin $fish_user_paths

# Environment variables
set -x BROWSER     chromium
set -x EDITOR      vim
set -x SXHKD_SHELL /bin/sh
