#!/bin/bash

# Install nvim with all the fancy stuff
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim

chmod +x nvim
sudo chown root:root nvim
sudo mv nvim /usr/bin

cd ~
mkdir -p .config/nvim

## vim-plug for nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## python modules for deoplete
sudo apt install python3-pip
sudo apt install python-pip
pip install --user neovim
pip3 install --user neovim

# AG - Silver Searcher
sudo apt-get install silversearcher-ag

# FZF
sudo apt-get install fzf

# Install VS Code + plugins
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code

code --install-extension emmanuelbeziat.vscode-great-icons
code --install-extension formulahendry.terminal
code --install-extension gerane.Theme-FlatlandMonokai
code --install-extension humao.rest-client
code --install-extension mjmcloug.vscode-elixir
code --install-extension saratravi.elixir-formatter
code --install-extension techer.open-in-browser
code --install-extension vscodevim.vim

# Install DBeaver
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update
sudo apt -y  install dbeaver-ce

# Install Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client

# Install Insomnia
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list

wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -

sudo apt-get update
sudo apt-get install insomnia

# Install keybase
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase

# Postgres and psql
sudo apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

# Docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce

## Add user to docker group in order to not have to use sudo to use docker
sudo usermod -a -G docker ${USER}
su - ${USER}

## Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# Kubernetes
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

## Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh

# AWS CLI
pip install awscli

