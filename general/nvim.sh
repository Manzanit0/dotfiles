#!/usr/bin/env bash

# NB: nvim has been installed by homebrew or apt.

# Link nvim config
mkdir -p ~/.config/nvim
echo "source ~/repositories/dotfiles/dotfiles/.nvimrc" > ~/.config/nvim/init.vim

# This is needed for many plugins
pip3 install neovim --upgrade

# Install vim-plug for plugin management
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install all plugins and update
nvim +PlugInstall +UpdateRemotePlugins +qa
