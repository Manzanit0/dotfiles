export ZSH="$HOME/.oh-my-zsh"

# Start up rbenv
eval "$(rbenv init -)"

plugins=(git osx tmux github fasd history-substring-search zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Load custom prompt (lambda-pure).
ZSH_THEME="lambda-pure"
autoload -U promptinit; promptinit
PURE_NODE_ENABLED=0
prompt lambda-pure

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Allow tmux work properly (hack?)
alias tmux="TERM=screen-256color-bce tmux"
set -g default-terminal "screen-256color"
