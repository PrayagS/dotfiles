# See zshoptions(1) for detailed description of each option
unsetopt menu_complete
setopt auto_menu
setopt auto_param_slash
setopt auto_remove_slash
setopt mark_dirs
setopt list_types list_packed
setopt complete_in_word
setopt completeinword
setopt always_to_end
setopt correct
setopt extendedglob
setopt aliases

# Tab complete into hidden files
setopt globdots

# Source for many zstyle options: https://github.com/mattmc3/zephyr/blob/main/plugins/compstyle/compstyle.plugin.zsh

# Enable completion menu
# zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' menu no

# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
  setopt case_glob
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
  unsetopt case_glob
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true
# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

zstyle ':completion:*' rehash true
# zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
zstyle ':completion:*:descriptions' format '[%d]'

# Enable LSCOLORS in completion menu
# zstyle ':completion:*' list-colors ''
# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{red}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages' format ' %F{green} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{yellow}-- no matches found --%f'
zstyle ':completion:*' format ' %F{blue}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# forces zsh to realize new commands
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# Increase the number of errors based on the length of the typed word. But make
# sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# History completion
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Enable completion while killing processes
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man pages completion
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# Use cache
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
