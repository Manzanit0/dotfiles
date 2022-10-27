# Uncomment to profile
# zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME=robbyrussell

plugins=(evalcache git macos tmux github fasd history-substring-search asdf)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

if type asdf &>/dev/null; then
  . $HOME/.asdf/asdf.sh
  fpath=(${ASDF_DIR}/completions $fpath)
fi

# autoload -Uz compinit && compinit

_evalcache direnv hook zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Enabled history for Elixir iex
export ERL_AFLAGS="-kernel shell_history enabled"

# GOPATH :)
# At the moment asdf is taking care of these.
# export GOROOT=$(go env GOROOT)
# export GOPATH=$(go env GOPATH)
# export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN/bin

# PHP
export PATH="$PATH:$HOME/.composer/vendor/bin"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Some convenience function
function docker-rm-all-containers {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
}

function docker-rm-all-images {
  docker-rm-all-containers
  docker rmi -f $(docker images -q)
}

function pg-docker {
  docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
}

function pg-stop {
  sudo /etc/init.d/postgresql stop
}

function pg-start {
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

# Invoke elixir help from terminal
# Usage: `exdoc Enum.map`
function exdoc {
  elixir -e "require IEx.Helpers; IEx.Helpers.h($1)"
}

function mfa-code {
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

function bw-unlock {
  # Depends on BW_PASSWORD env var being exported in the environment.
  export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
}

function timezsh {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

function fkill {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    kill -${1:-9} $pid
  fi
}

path() {
  echo $PATH | tr ':' '\n'
}

alias dict="dict -d wn"
alias httpry="httpry -f timestamp,dest-ip,direction,method,status-code,host,request-uri"

alias /$=''
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias ls='ls -FGh'

alias aws-params='open "https://eu-west-1.console.aws.amazon.com/systems-manager/parameters/?region=eu-west-1&tab=Table"'

alias rw="railway"

# Allow tmux work properly (hack?)
# alias tmux="TERM=screen-256color-bce tmux"
# set -g default-terminal "screen-256color"
#
alias update-nvim-stable='asdf uninstall neovim stable && asdf install neovim stable'
alias update-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'
alias update-nvim-master='asdf uninstall neovim ref:master && asdf install neovim ref:master'

# Some handy aliases to work with Bitwarden CLI
alias bw-search='bw list items --search'
alias bw-pw-copy="jq -r '.[0].login.password' | pbcopy"
alias bw-generate='bw generate -p --words 4 --separator $'

alias up='docker compose up'
alias down='docker compose down'
alias dp='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'

alias vim='nvim'

alias ssh-ls='ps aux | grep ssh'

alias ez="$EDITOR ~/repositories/dotfiles/dotfiles/.zshrc"
alias sz="source ~/.zshrc"
# Uncomment to profile
# zprof
