HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"

# See zshmodules(1) for this killer function
bindkey '^h' accept-and-infer-next-history

# See zshoptions(1) for detailed description of each option
setopt extended_history
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
# setopt inc_append_history
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# Performance optimization
setopt HIST_FCNTL_LOCK

# Disabling in favor of zsh-autosuggestions
# fuzzy find history: start to type
# autoload up-line-or-beginning-search; zle -N up-line-or-beginning-search
# autoload down-line-or-beginning-search; zle -N down-line-or-beginning-search
# bindkey '^k' up-line-or-beginning-search
# bindkey '^j' down-line-or-beginning-search


zstyle ":history-search-multi-word" page-size "20"
zstyle ":plugin:history-search-multi-word" active "standout"
