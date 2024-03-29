#!/usr/bin/env bash

if ! [[ $(command -v brew) ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew analytics off
brew update

taps=(
  'homebrew/bundle'
  'homebrew/services'
  'adoptopenjdk/openjdk'
  'heroku/brew'
)

formulas=(
  'adoptopenjdk8'
  'adoptopenjdk9'
  'adoptopenjdk10'
  'adoptopenjdk11'
  'bandwhich'
  'bash'
  'bat'
  'cloc'
  'cmake'
  'coreutils'
  'curl'
  'diff-so-fancy'
  'direnv'
  'deno'
  'fzf'
  'git'
  'glow'
  'grep'
  'gzip'
  'heroku'
  'htop'
  'insect'
  'jq'
  'lzop'
  'make'
  'ncdu'
  'neovim'
  'node'
  'ripgrep',
  'openssl'
  'pgcli'
  'postgresql'
  'python3'
  'the_silver_searcher'
  'tldr'
  'trash'
  'tree'
  'vim --override-system-vi --with-python3'
  'wget'
)

casks=(
  'docker'
  'firefox'
  'google-chrome'
  'postman'
  'iterm2'
  'java'
  'ngrok'
  'slack'
  'telegram'
  'visual-studio-code'
  'spotify'
  'rectangle'
  'zoom'
)

for tap in "${taps[@]}"; do
  brew tap "$tap"
done

for formula in "${formulas[@]}"; do
  eval "brew install ${formula}"
done

for cask in "${casks[@]}"; do
  brew install --cask "$cask"
done
