if not set -q TMUX
    set -g TMUX tmux new-session -d -s 0
    eval $TMUX
    tmux attach-session -d -t 0
end
