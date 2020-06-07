export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME=robbyrussell

# Start up rbenv
eval "$(rbenv init -)"

plugins=(git osx tmux github fasd history-substring-search zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Enabled history for Elixir iex
export ERL_AFLAGS="-kernel shell_history enabled"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Allow tmux work properly (hack?)
alias tmux="TERM=screen-256color-bce tmux"
set -g default-terminal "screen-256color"

# GOPATH :)
export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$(go env GOPATH)/bin

# Some convenience function
function deleteAllDockerContainers() {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
}

function deleteAllDockerImages() {
  docker rmi $(docker images -q)
}

function localpg {
  docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
}

# Rekki stuff
function rekkifeat() {
  kubectl exec -ti svc/pgcli -n feat -- /bin/open.sh order
}

function rekkilive() {
  kubectl exec -ti svc/pgcli -n live -- /bin/open.sh order
}
