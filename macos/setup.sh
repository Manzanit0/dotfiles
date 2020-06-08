#!/usr/bin/env bash -xe

if [[ "$(uname)" != "Darwin" ]]; then
  echo 'This setup only runs on OS X machines'
  exit 1
fi

# Install Command Line Tools if not yet installed.
xcode-select -p 1>/dev/null || xcode-select --install

# Set up SSH key if none exists
if [[ ! -f ~/.ssh/id_rsa ]]; then
  ssh-keygen -t rsa -b 4096 -C "unico.javier@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  open https://github.com/settings/keys
  read -p "Copied public SSH key. Add to GitHub then press Enter to continue..."
fi

mkdir -p ~/repositories

rm -rf ~/repositories/dotfiles
git clone git@github.com:Manzanit0/dotfiles.git ~/repositories/dotfiles

pushd ~/repositories/dotfiles/dotfiles
  bash link_dotfiles.sh -f
popd

pushd ~/repositories/dotfiles/macos
  bash os-defaults.sh \
  && bash homebrew.sh
popd

pushd ~/repositories/dotfiles/general
  bash tmux.sh \
  && bash asdf.sh \
  && bash nvim.sh \
  && bash vscode.sh
popd


# as of Cataline, ZSH is the default shell, so we only need to bring OMZsh :)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "All done!"
