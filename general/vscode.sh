#!/usr/bin/env bash

# TODO do this but for vs codium

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

apt-get install apt-transport-https
apt-get update
apt-get install code

# Extensions
## theming
code --install-extension emmanuelbeziat.vscode-great-icons
code --install-extension gerane.Theme-FlatlandMonokai
code --install-extension anotherglitchinthematrix.monochrome

## terminal
code --install-extension formulahendry.terminal
code --install-extension msamueltscott.maximizeterminal

## general stuff
code --install-extension vscodevim.vim
code --install-extension humao.rest-client
code --install-extension techer.open-in-browser
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension manzanit0.heroku-vscode
code --install-extension deamodio.gitlens
code --install-extension buenon.scratchpads
code --install-extension mtxr.sqltools
code --install-extension mtxr.sqltools-driver-pg
code --install-extension ms-vscode.sublime-keybindings
code --install-extension tomoki1207.pdf

# elixir
code --install-extension jakebecker.elixir-ls
code --install-extension saratravi.elixir-formatter

# dotnet
code --install-extension ms-dotnettools.csharp
code --install-extension austincummings.razor-plus
code --install-extension dms-vscode.js-debug-nightly

# js
code --install-extension dbaeumer.vscode-eslint

# go
code --install-extension dms-vscode.go