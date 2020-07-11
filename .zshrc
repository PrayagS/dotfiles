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
unsetopt menu_complete
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt correct

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

# Disabling in favor of zsh-autosuggestions
# fuzzy find history: start to type
# autoload up-line-or-beginning-search; zle -N up-line-or-beginning-search
# autoload down-line-or-beginning-search; zle -N down-line-or-beginning-search
# bindkey '^k' up-line-or-beginning-search
# bindkey '^j' down-line-or-beginning-search

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
# Enable colors
#

source ~/.config/zsh/ohmyzsh/lib/spectrum.zsh

# ls colors
autoload -U colors && colors

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# For GNU ls, use the default ls color theme. They can later be overwritten by themes.
if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi

ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

setopt auto_cd
setopt multios
setopt prompt_subst

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="git:("         # Prefix at the very beginning of the prompt, before the branch name
ZSH_THEME_GIT_PROMPT_SUFFIX=")"             # At the very end of the prompt
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean
ZSH_THEME_RUBY_PROMPT_PREFIX="("
ZSH_THEME_RUBY_PROMPT_SUFFIX=")"

source ~/.config/zsh/ohmyzsh/lib/git.zsh

# Aliases
source ~/.config/zsh/aliases.zsh

# fasd
eval "$(fasd --init auto)"

#
# Plugins
#

export ZSH="$HOME/.config/zsh/ohmyzsh"

source ~/.config/zsh/ohmyzsh/plugins/archlinux/archlinux.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/command-not-found/command-not-found.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/copyfile/copyfile.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/copydir/copydir.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/extract/extract.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/git/git.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/transfer/transfer.plugin.zsh

source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.config/zsh/plugins/copy-pasta/copy-pasta.plugin.zsh
source ~/.config/zsh/plugins/gitignore/gitignore.plugin.zsh
source ~/.config/zsh/plugins/history-search-multi-word/history-search-multi-word.plugin.zsh
source ~/.config/zsh/plugins/fzf-fasd/fzf-fasd.plugin.zsh

#
# Theme
#

source ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
source ~/.config/zsh/themes/.p10k.zsh

