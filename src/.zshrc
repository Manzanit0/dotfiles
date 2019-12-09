export ZSH="$HOME/.oh-my-zsh"

# Start up rbenv
eval "$(rbenv init -)"

plugins=(git osx tmux github fasd history-substring-search zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Load custom prompt – github.com/sindresorhus/pure
autoload -U promptinit; promptinit
PURE_PROMPT_SYMBOL='%(?.%F{yellow}λ.%F{red}λ)%f '
prompt pure

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Enabled history for Elixir iex
export ERL_AFLAGS="-kernel shell_history enabled"
export EDITOR='nvim'

# Allow tmux work properly (hack?)
alias tmux="TERM=screen-256color-bce tmux"
set -g default-terminal "screen-256color"
