export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME=robbyrussell

plugins=(git osx tmux github fasd history-substring-search)

source $ZSH/oh-my-zsh.sh

# Enabled history for Elixir iex
export ERL_AFLAGS="-kernel shell_history enabled"

# Invoke elixir help from terminal
# Usage: `exdoc Enum.map`
function exdoc {
  elixir -e "require IEx.Helpers; IEx.Helpers.h($1)"
}

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# <asdf-config>
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit
# </asdf-config>

# Allow tmux work properly (hack?)
alias tmux="TERM=screen-256color-bce tmux"
set -g default-terminal "screen-256color"

# GOPATH :)
export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$(go env GOPATH)/bin

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Some convenience function
function deleteAllDockerContainers() {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
}

function deleteAllDockerImages() {
  docker rmi $(docker images -q)
}

function pg-docker() {
  docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
}

function pg-stop() {
  sudo /etc/init.d/postgresql stop
}

function pg-start() {
  sudo /etc/init.d/postgresql start
}

# Rekki stuff
export PATH=$PATH:/home/manzanit0/repositories/rekki/go/.bin

function rekkifeat() {
  kubectl exec -ti svc/pgcli -n feat -- /bin/open.sh order
}

function rekkilive() {
  kubectl exec -ti svc/pgcli -n live -- /bin/open.sh order
}

function rincewind-connect() {
  lftp ftp.rekki.com -u javier
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
