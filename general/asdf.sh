#!/usr/bin/env bash

git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"

# I use zsh, but make it work in bash too for the odd day
echo ". $HOME/.asdf/asdf.sh" > ~/.bashrc
echo ". $HOME/.asdf/completions/asdf.bash" > ~/.bashrc

# Go
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang 1.14.4
asdf global golang 1.14.4

# Elixir/Erlang/OTP
# Some necessary libs for Erlang
if [[ "$(uname)" == "Linux" ]]; then
    apt-get -y install build-essential
    apt-get -y install autoconf
    apt-get -y install m4
    apt-get -y install libncurses5-dev
    apt-get -y install libwxgtk3.0-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev
    apt-get -y install libssh-dev
    apt-get -y install unixodbc-dev
    apt-get install xsltproc fop

    export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"
fi

if [[ "$(uname)" == "Darwin" ]]; then
    brew install autoconf

    export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl)"
fi

asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install erlang 23.0.2
asdf global erlang 23.0.2

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install elixir 1.10.3-otp-23
asdf global elixir 1.10.3-otp-23

# NodeJS
if [[ "$(uname)" == "Linux" ]]; then
    apt-get install dirmngr
    apt-get install gpg
    apt-get install curl
fi

if [[ "$(uname)" == "Darwin" ]]; then
    brew install coreutils
    brew install gpg
fi

asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf install nodejs 14.4.0
asdf global nodejs 14.4.0