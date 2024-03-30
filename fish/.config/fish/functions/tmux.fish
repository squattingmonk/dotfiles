# Used because tmux doesn't respect XDG_CONFIG
function tmux --description 'alias tmux=tmux -f /home/squattingmonk/.config/tmux/tmux.conf'
    command tmux -f /home/squattingmonk/.config/tmux/tmux.conf $argv
end
