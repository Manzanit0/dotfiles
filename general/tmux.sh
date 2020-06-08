#!/usr/bin/env bash -xe

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "source ~/repositories/dotfiles/dotfiles/.tmux.conf" > ~/.tmux.conf

if [[ "$(uname)" == "Linux" ]]; then
    apt install -y tmux
    apt install fonts-powerline
fi

# TODO can't remember for MacOS. We'll see next time :)

# TODO Remember to then install all tmux plugins it with ctrl + b + I
