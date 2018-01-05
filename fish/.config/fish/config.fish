#!/usr/bin/fish

# Disable the greeting
set fish_greeting

# Source all files in /etc/profile.d
env -i HOME=$HOME dash -l -c 'export -p' | sed -e "/PWD/d; /PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

# Set up rubygems if needed
if type -q gem
    set GEM_PATH (ruby -e 'print Gem.user_dir')/bin
    mkdir -p $GEM_PATH
end

# Set our path
set -x PATH $HOME/.bin $GEM_PATH $PATH

# Environment variables
set -x BROWSER firefox
set -x EDITOR  vim

# Ensure fish plays nicely with sxhkd
set -x -g SXHKD_SHELL /bin/sh

# Set up our colors
set fish_color_normal       normal
set fish_color_command      brblue
set fish_color_comment      brblack
set fish_color_error        brred
set fish_color_param        cyan
set fish_color_quote        green
set fish_color_operator     bryellow
set fish_color_redirection  brblue
set fish_color_search_match --background=white

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
    end
end
