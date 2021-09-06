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
# zmodload zsh/zprof

#
# Completion settings
#

# Tab complete into hidden files
_comp_options+=(globdots)

# See zshoptions(1) for detailed description of each option
unsetopt menu_complete
setopt auto_menu
setopt auto_param_slash
setopt auto_remove_slash
setopt mark_dirs
setopt list_types list_packed
setopt complete_in_word
setopt always_to_end
setopt correct
setopt extendedglob


# Enable completion menu
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

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
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,%cpu,%mem,cputime,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man pages completion
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Use cache
zstyle ':completion:*' accept-exact '*(N)'
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
setopt hist_reduce_blanks
setopt inc_append_history
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
bindkey '^[[1;5C' vi-forward-word
bindkey '^[[1;5D' vi-backward-word

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

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

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

# mkcd
function mkcd() {
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

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

# source ~/.config/zsh/ohmyzsh/lib/git.zsh

# Aliases
source ~/.config/zsh/aliases.zsh

# nnn config
# source ~/.config/nnn/nnn.zsh

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
        NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -e "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

alias N='sudo -E n -e'

# fasd
# eval "$(fasd --init auto)"
eval "$(zoxide init zsh)"

# lazygit
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

kind-setup() {
    kind create cluster
    VERSION=$(curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/stable.txt)
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/${VERSION}/deploy/static/provider/kind/deploy.yaml
    kubectl wait --namespace ingress-nginx \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s
}

#
# Plugins
#

export ZSH="$HOME/.config/zsh/ohmyzsh"

source ~/.config/zsh/ohmyzsh/plugins/archlinux/archlinux.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/command-not-found/command-not-found.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/extract/extract.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/git/git.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/transfer/transfer.plugin.zsh
source ~/.config/zsh/ohmyzsh/plugins/zoxide/zoxide.plugin.zsh

source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-execute
bindkey '^[[1;6C' autosuggest-accept

source ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
export FAST_HIGHLIGHT[ointeractive_comments]=0

source ~/.config/zsh/plugins/copy-pasta/copy-pasta.plugin.zsh
source ~/.config/zsh/plugins/gitignore/gitignore.plugin.zsh
source ~/.config/zsh/plugins/history-search-multi-word/history-search-multi-word.plugin.zsh

export forgit_log=fglo
export forgit_diff=fgd
export forgit_add=fga
export forgit_reset_head=fgrh
export forgit_ignore=fgi
export forgit_restore=fgcf
export forgit_clean=fgclean
export forgit_stash_show=fgss
export forgit_cherry_pick=fgcp
source ~/.config/zsh/plugins/forgit/forgit.plugin.zsh

source ~/.config/zsh/plugins/git-it-on.zsh/git-it-on.plugin.zsh
source <(echo "$(navi widget zsh)")

#
# Theme
#

source ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
source ~/.config/zsh/themes/.p10k.zsh

# eval "$(starship init zsh)"
\cat ~/.cache/wal/sequences

# Completions
[[ ~/bin/kubectl ]] && source <(kubectl completion zsh)

