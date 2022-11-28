#!/usr/bin/env bash -xe

rm -rf ~/repositories/dotfiles
git clone git@github.com:Manzanit0/dotfiles.git ~/repositories/dotfiles

if [[ "$(uname)" == "Darwin" ]]; then
  pushd ~/repositories/dotfiles
    bash macos/setup.sh
  popd
fi

if [[ "$(uname)" == "Linux" ]]; then
  pushd ~/repositories/dotfiles
    bash ubuntu/setup.sh
  popd
fi
