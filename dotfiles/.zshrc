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
# alias tmux="TERM=screen-256color-bce tmux"
export TERM="screen-256color"

# GOPATH :)
export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$(go env GOPATH)/bin

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# <deno>
export DENO_INSTALL="/home/manzanit0/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# </deno>

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

function find-pods {
  kubectl get pods -n $1 -l name=$2
}

function find-service-version {
  kubectl describe -n $1 deploy/$2 | grep Imag
}

eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

# Default dict already
alias dict="dict -d wn"

# Default style
alias httpry="httpry -f timestamp,dest-ip,direction,method,status-code,host,request-uri"

# I only use VSCode to open projects, not files.
alias code="code ."

function kc {
  cd ~/settld/kc-api
  source .envrc
  code
}

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/manzanit0/repositories/rekki/unity/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/manzanit0/repositories/rekki/unity/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/manzanit0/repositories/rekki/unity/node_modules/tabtab/.completions/sls.zsh ]] && . /home/manzanit0/repositories/rekki/unity/node_modules/tabtab/.completions/sls.zsh
