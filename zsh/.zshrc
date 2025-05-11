#
#  ███████╗███████╗██╗  ██╗
#  ╚══███╔╝██╔════╝██║  ██║
#    ███╔╝ ███████╗███████║
#   ███╔╝  ╚════██║██╔══██║
#  ███████╗███████║██║  ██║
#  ╚══════╝╚══════╝╚═╝  ╚═╝
#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set Zsh location vars.
ZSH_CONFIG_DIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p $ZSH_CONFIG_DIR $ZSH_DATA_DIR $ZSH_CACHE_DIR

source "${ZSH_CONFIG_DIR}/options.zsh"
source "${ZSH_CONFIG_DIR}/bindkeys.zsh"
source "${ZSH_CONFIG_DIR}/history.zsh"
source "${ZSH_CONFIG_DIR}/aliases.zsh"
source "${ZSH_CONFIG_DIR}/functions.zsh"
source "${ZSH_CONFIG_DIR}/completion.zsh"

zstyle ':plugin:ez-compinit' 'use-cache' 'yes'

export GLOBALIAS_FILTER_VALUES=("l" "ls" "less" "z" "fd" "sudo" "mkdir" "cp" "mv")

zstyle ':fzf-tab:*' fzf-pad 250
zstyle ':fzf-tab:*' continuous-trigger ']'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group 'ctrl-h' 'ctrl-l'
export LESSOPEN="|${ZSH_CONFIG_DIR}/lessfilter %s"
zstyle ':fzf-tab:sources' config-directory ${ZSH_HOME}/fzf-tab-custom-sources

zstyle :history-search-multi-word page-size 20
zstyle :history-search-multi-word highlight-color 'fg=#b8bb26,bold'
zstyle :plugin:history-search-multi-word active 'bg=#504945'
zstyle :plugin:history-search-multi-word clear-on-cancel 'yes'

zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:*' zcompile 'yes'

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

export ATUIN_NOBIND='true'

# Lazy-load antidote from its functions directory.
fpath=(${ZSH_CONFIG_DIR}/.antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

source "${ZSH_CONFIG_DIR}/themes/.p10k.zsh"

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)"
bindkey -M viins '^]' autosuggest-execute
bindkey -M vicmd '^]' autosuggest-execute

export FAST_HIGHLIGHT_STYLES[comment]='fg=yellow,bold'
export FAST_HIGHLIGHT_STYLES[global]='fg=green,bold'
zle_highlight=('paste:none')

bindkey '^[e' _atuin_search_widget

export CD_LS_COMMAND="l"

export ZSH_EVALCACHE_DIR="${ZSH_CACHE_DIR}/evalcache"
_evalcache zoxide init zsh

_lazy_load bd "bd completion zsh"
_lazy_load jj "COMPLETE=zsh jj"
_lazy_load gh "gh completion zsh"
_lazy_load rg "rg --generate complete-zsh"
_lazy_load helm "helm completion zsh"
