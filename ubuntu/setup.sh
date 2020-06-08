#!/bin/bash

# Install nvim with all the fancy stuff
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim

chmod +x nvim
chown root:root nvim
mv nvim /usr/bin

cd ~
mkdir -p .config/nvim

## vim-plug for nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## python modules for deoplete
apt install python3-pip
apt install python-pip
pip install --user neovim
pip3 install --user neovim

# AG - Silver Searcher
apt-get install silversearcher-ag

# FZF
apt-get install fzf

# Install VS Code + plugins
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

apt-get install apt-transport-https
apt-get update
apt-get install code

code --install-extension emmanuelbeziat.vscode-great-icons
code --install-extension formulahendry.terminal
code --install-extension gerane.Theme-FlatlandMonokai
code --install-extension humao.rest-client
code --install-extension mjmcloug.vscode-elixir
code --install-extension saratravi.elixir-formatter
code --install-extension techer.open-in-browser
code --install-extension vscodevim.vim

# Install DBeaver
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | apt-key add -
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | tee /etc/apt/sources.list.d/dbeaver.list
apt update
apt -y  install dbeaver-ce

# Install Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | apt-key add -
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list

apt-get update && apt-get install spotify-client

# Install Insomnia
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | tee -a /etc/apt/sources.list.d/insomnia.list

wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | apt-key add -

apt-get update
apt-get install insomnia

# Install keybase
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
apt install ./keybase_amd64.deb
run_keybase

# Postgres and psql
apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
apt-get update
apt-get install postgresql postgresql-contrib

# Docker
apt update
apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update
apt-cache policy docker-ce
apt install docker-ce

## Add user to docker group in order to not have to use to use docker
usermod -a -G docker ${USER}
su - ${USER}

## Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# Kubernetes
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

## Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh

# AWS CLI
pip install awscli
