#!/bin/bash

pushd ~/repositories/dotfiles/general
  bash tmux.sh \
  && bash asdf.sh \
  && bash nvim.sh \
  && bash vscode.sh
popd

# Node should come with asdf.sh
npm install -g diff-so-fancy

# let's make zsh the default
apt install -y zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

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

# Alacritty
add-apt-repository ppa:mmstick76/alacritty
apt install alacritty
