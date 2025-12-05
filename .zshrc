export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)

# Ваши алиасы
alias n='nvim'
alias m='make'
alias dc='docker compose'
alias cls='clear'

export PATH="/snap/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Starship в конце
eval "$(starship init zsh)"
source $ZSH/oh-my-zsh.sh
