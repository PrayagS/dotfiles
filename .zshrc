#
#  ███████╗███████╗██╗  ██╗
#  ╚══███╔╝██╔════╝██║  ██║
#    ███╔╝ ███████╗███████║
#   ███╔╝  ╚════██║██╔══██║
#  ███████╗███████║██║  ██║
#  ╚══════╝╚══════╝╚═╝  ╚═╝
#

# Initialize completion
autoload -Uz compinit
_comp_path="$HOME/.zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
  # -C (skip function check) implies -i (skip security check).
  compinit -C -d "$_comp_path"
else
  mkdir -p "$_comp_path:h"
  compinit -i -d "$_comp_path"
fi
unset _comp_path

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit
zmodload -i zsh/complist

# Compile the completion dump in background to increase startup speed.
{
  zcompdump="$HOME/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# TODO: Remove this when done profiling
zmodload zsh/zprof

#
# Completion settings
#

# Tab complete into hidden files
_comp_options+=(globdots)

# See zshoptions(1) for detailed description of each option
setopt menu_complete
unsetopt auto_menu
setopt complete_in_word
setopt always_to_end

# Enable completion menu
zstyle ':completion:*:*:*:*:*' menu select

# Enable LSCOLORS in completion menu
zstyle ':completion:*' list-colors ''

# forces zsh to realize new commands
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate

# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# History completion
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Enable completion while killing processes
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man pages completion
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Use cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

#
# History settings
#

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
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# Performance optimization
setopt HIST_FCNTL_LOCK

autoload up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload down-line-or-beginning-search; zle -N down-line-or-beginning-search

# fuzzy find history: start to type
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search

#
# Vi key bindings
#

bindkey -v
export KEYTIMEOUT=1

bindkey -a 'u' undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^r' history-incremental-search-backward
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history
bindkey -a 'j' vi-down-line-or-history
bindkey -a 'k' vi-up-line-or-history

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#
# Misc
#

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Enable comments in the shell
setopt interactive_comments

# Alt-S to toggle sudo
function vbe-sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N vbe-sudo-command-line
bindkey "\es" vbe-sudo-command-line

# Do not overwrite existing files with > and >>.
# Use >! and >>! to bypass
unsetopt CLOBBER

#
# oh-my-zsh defaults (not all of them)
#

source ~/.config/zsh/ohmyzsh/lib/git.zsh
source ~/.config/zsh/ohmyzsh/lib/spectrum.zsh
source ~/.config/zsh/ohmyzsh/lib/theme-and-appearance.zsh
