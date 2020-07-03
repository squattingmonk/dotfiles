#!/usr/bin/fish

# Disable the greeting
set fish_greeting

# Set our XDG directories
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_DATA_DIRS /usr/local/share:/usr/share
set -x XDG_CONFIG_DIRS /etc/xdg

# Bootstrap fisher installation
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Source all files in /etc/profile.d
# Requires 'fisher add "edc/bass"'
if not functions -q bass
    fisher add "edc/bass"
end
bass source /etc/profile

# Set up rubygems if needed
if type -q gem
    set -x GEM_HOME $XDG_DATA_HOME/gem
    set -x GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
    mkdir -p $GEM_HOME $GEM_SPEC_CACHE
end

# Add choosenim's nimble location
set NIMBLE_PATH $XDG_DATA_HOME/nimble/bin

# Set our user paths if not set
if not set -q -U fish_user_paths
    set -U fish_user_paths ~/.local/bin $NIMBLE_PATH $GEM_PATH
end

# Default programs
set -x BROWSER firefox
set -x EDITOR  nvim

# Clean up home directory
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -x GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0
set -x SQLITE_HISTORY $XDG_DATA_HOME/sqlite3/history
set -x INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -x LESSHISTFILE "-"
set -x MYSQL_HISTFILE $XDG_DATA_HOME/mysql/history
set -x WINEPREFIX $XDG_DATA_HOME/wineprefixes/default
set -x XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -x XINITRC $XDG_CONFIG_HOME/xorg/xinitrc
set -x XRESOURCES $XDG_CONFIG_HOME/xorg/xresources

# Aliases for programs that dont's respect XDG
if not functions -q tmux
    alias -s tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
end

# Ensure fish plays nicely with sxhkd
set -x -g SXHKD_SHELL /bin/sh

# Set up our colors
set fish_color_normal       normal
set fish_color_command      brblue
set fish_color_comment      brblack
set fish_color_error        brred
set fish_color_end          green
set fish_color_param        cyan
set fish_color_quote        green
set fish_color_operator     bryellow
set fish_color_redirection  green
set fish_color_search_match --background=white

# Settings for Spacefish Theme
set SPACEFISH_PROMPT_ORDER user dir host git line_sep vi_mode jobs char
set SPACEFISH_CHAR_SYMBOL '->'

# Use fd with fzf if it is available
if type -q fd
    set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
end

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx $XINITRC -- -keeptty
    end
end
