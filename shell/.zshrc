export PATH="$HOME/.local/bin:$PATH"
eval "$(rbenv init -)"
#export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_VERIFY

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Aliases
alias ls='ls -F'
alias ll='ls -lAhG'
alias la='ls -AG'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship prompt (must be last)
eval "$(starship init zsh)"
