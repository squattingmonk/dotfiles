# Set our XDG directories
set -gx --path XDG_DATA_DIRS /usr/local/share /usr/share
set -gx --path XDG_CONFIG_DIRS /etc/xdg
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_DESKTOP_DIR $HOME/Desktop
set -gx XDG_DOWNLOAD_DIR $HOME/Downloads
set -gx XDG_DOCUMENTS_DIR $HOME/Documents
set -gx XDG_MUSIC_DIR $HOME/Music
set -gx XDG_PICTURES_DIR $HOME/Pictures
set -gx XDG_VIDEOS_DIR $HOME/Videos

# Default programs
set -gx BROWSER zen-browser
set -gx EDITOR nvim

# Clean up home directory
set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0
set -gx SQLITE_HISTORY $XDG_DATA_HOME/sqlite3/history
set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -gx MYSQL_HISTFILE $XDG_DATA_HOME/mysql/history
set -gx WINEPREFIX $XDG_DATA_HOME/wineprefixes/default
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx XINITRC $XDG_CONFIG_HOME/xorg/xinitrc
set -gx XRESOURCES $XDG_CONFIG_HOME/xorg/xresources
set -gx LESSHISTFILE -

# Steam helpers
set -gx STEAM_COMPAT_DATA_PATH $XDG_DATA_HOME/proton
set -gx STEAM_PATH $XDG_DATA_HOME/Steam/steamapps/common
set -gx NWN_ROOT "$STEAM_PATH/Neverwinter Nights"

# Ensure fish plays nicely with sxhkd
set -gx SXHKD_SHELL /bin/sh

# Set up rubygems if needed
if type -q gem
    set -gx GEM_HOME (gem env user_gemhome)
    set -gx GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
    mkdir -p $GEM_HOME $GEM_SPEC_CACHE
end
