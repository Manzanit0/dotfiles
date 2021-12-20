export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME=robbyrussell

plugins=(evalcache git macos tmux github fasd history-substring-search asdf vscode mix deno aws)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

source $ZSH/oh-my-zsh.sh

if type asdf &>/dev/null; then
  . $HOME/.asdf/asdf.sh
  fpath=(${ASDF_DIR}/completions $fpath)

  autoload -Uz compinit
  compinit
fi

_evalcache direnv hook zsh

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

# Allow tmux work properly (hack?)
alias tmux="TERM=screen-256color-bce tmux"
set -g default-terminal "screen-256color"

# GOPATH :)
export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$(go env GOPATH)/bin

# PHP
export PATH="$PATH:$HOME/.composer/vendor/bin"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Some convenience function
function docker-rm-all-containers() {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
}

function docker-rm-all-images() {
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

function find-pods {
  kubectl get pods -n $1 -l name=$2
}

function uuid {
  uuidgen | tr '[:upper:]' '[:lower:]'
}

function source-dotnenv {
  set -o allexport
  source .env
  set +o allexport
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias dict="dict -d wn"
alias httpry="httpry -f timestamp,dest-ip,direction,method,status-code,host,request-uri"

alias /$=''
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias ls='ls -FGh'

alias aws-params='open "https://eu-west-1.console.aws.amazon.com/systems-manager/parameters/?region=eu-west-1&tab=Table"'

alias rw="railway"

function mfa-code() {
  local paster
  if [ -z "$(command -v gauth)" ]; then
    echo "gauth is not available run: go get github.com/pcarrier/gauth" >&2
    return 1
  fi
  paster=cat
  # case "$(uname -s)" in
  # 	([Dd]arwin*) paster="pbcopy"  ;;
  # 	([Ll]inux*) paster="xclip -i"  ;;
  # esac
  gauth | grep -i "$1" | awk '{print $(NF-1)}' | $paster
}

# Some handy aliases to work with Bitwarden CLI
alias bw-search='bw list items --search'
alias bw-pw-copy="jq -r '.[0].login.password' | pbcopy"
alias bw-generate='bw generate -p --words 4 --separator $'

function bw-unlock() {
  # Depends on BW_PASSWORD env var being exported in the environment.
  export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
}

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

alias up='docker compose up'
alias down='docker compose down'
alias dp='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'
