#!/usr/bin/env bash

# Install nvim with all the fancy stuff
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim

chmod +x nvim
chown root:root nvim
mv nvim /usr/bin

# Link nvim config
mkdir -p ~/.config/nvim
echo "source ~/repositories/dotfiles/dotfiles/.nvimrc" > ~/.config/nvim/init.vim

if [[ "$(uname)" == "Linux" ]]; then
    apt-get install silversearcher-ag
    apt-get install fzf

    ## python modules for deoplete
    # FIXME: Last time the came with Ubuntu out of the box
    # apt install python3-pip
    # apt install python-pip
    # pip install --user neovim
    # pip3 install --user neovim
fi

# This is needed for many plugins
pip3 install neovim --upgrade

# Install vim-plug for plugin management
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install all plugins and update
nvim +PlugInstall +UpdateRemotePlugins +qa


# This is the Elixir language server needed for the Elixir setup in vim.
# git clone git@github.com:elixir-lsp/elixir-ls.git ~/.elixir-ls && cd ~/.elixir-ls && git checkout tags/v0.6.2 && mix do deps.get, compile, elixir_ls.release -o rel
git clone git@github.com:elixir-lsp/elixir-ls.git ~/repositories/elixir-ls
pushd ~/repositories/elixir_ls
  git checkout tags/v0.7.0
  mix deps.get && mix compile
  mkdir rel
  mix elixir_ls.release -o rel
popd
