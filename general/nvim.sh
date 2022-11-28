#!/usr/bin/env bash

# Install nvim with all the fancy stuff
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim

chmod +x nvim
chown root:root nvim
mv nvim /usr/bin

# Link nvim config
mkdir -p ~/.config/nvim
echo "source ~/repositories/dotfiles/dotfiles/.nvimrc" > ~/.config/nvim/init.vim

# This is needed for many plugins
pip3 install neovim --upgrade

# Install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install all plugins and update
nvim +PackerInstall +PackerSync +qa
