#
#  ███████╗███████╗██╗  ██╗
#  ╚══███╔╝██╔════╝██║  ██║
#    ███╔╝ ███████╗███████║
#   ███╔╝  ╚════██║██╔══██║
#  ███████╗███████║██║  ██║
#  ╚══════╝╚══════╝╚═╝  ╚═╝
#

ZSH_HOME="$HOME/.config/zsh"

# Source: https://github.com/zdharma-continuum/zinit-configs/blob/master/agkozak/zshrc
compile_or_recompile() {
  local file
  for file in "$@"; do
    if [[ -f $file ]] && [[ ! -f ${file}.zwc ]] \
      || [[ $file -nt ${file}.zwc ]]; then
      zcompile "$file"
    fi
  done
}
compile_or_recompile "${ZSH_HOME}/.zshenv" "${HOME}/.zshrc"

# Define zinit envars
typeset -gAH ZINIT;
ZINIT[HOME_DIR]=${ZSH_HOME}/zinit
ZINIT[BIN_DIR]=$ZINIT[HOME_DIR]/zinit.git
ZINIT[COMPLETIONS_DIR]=$ZINIT[HOME_DIR]/completions
ZINIT[SNIPPETS_DIR]=$ZINIT[HOME_DIR]/snippets
ZINIT[ZCOMPDUMP_PATH]=$ZINIT[HOME_DIR]/zcompdump
ZINIT[PLUGINS_DIR]=$ZINIT[HOME_DIR]/plugins
ZPFX=$ZINIT[HOME_DIR]/polaris

### Added by Zinit's installer
if [[ ! -f ${ZINIT[HOME_DIR]}/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "${ZINIT[HOME_DIR]}" && command chmod g-rwX "${ZINIT[HOME_DIR]}"
    command git clone https://github.com/zdharma-continuum/zinit "${ZINIT[HOME_DIR]}/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "${ZINIT[HOME_DIR]}/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-binary-symlink \
    zdharma-continuum/zinit-annex-link-man \
    zdharma-continuum/zinit-annex-rust
    # zdharma-continuum/zinit-annex-patch-dl \

### End of Zinit's installer chunk

zinit snippet "${ZSH_HOME}/options.zsh"
zinit snippet "${ZSH_HOME}/bindkeys.zsh"
zinit snippet "${ZSH_HOME}/history.zsh"
zinit snippet "${ZSH_HOME}/aliases.zsh"
zinit snippet "${ZSH_HOME}/functions.zsh"
zinit snippet "${ZSH_HOME}/completion.zsh"

# Prompt
PS1="READY >"
zinit ice wait"!" lucid atload"source ${ZSH_HOME}/themes/.p10k.zsh; _p9k_precmd" nocd
zinit light romkatv/powerlevel10k

# Make sure zoxide is installed before loading its zsh plugin
zinit from"gh-r" binary lman for \
    sbin"**/zoxide" ajeetdsouza/zoxide

# First set of plugins
zinit lucid light-mode wait"0a" for \
        OMZL::git.zsh \
        OMZL::clipboard.zsh \
        OMZP::git \
        hlissner/zsh-autopair \
        https://github.com/ajeetdsouza/zoxide/blob/main/zoxide.plugin.zsh \
    atload'export GLOBALIAS_FILTER_VALUES=("l" "ls" "less")' \
        OMZP::globalias \
    atload'alias -g cdg="cd-gitroot"' \
        mollifier/cd-gitroot \
    compile'lib/*f*~*.zwc' \
    blockf \
    atload"
      zstyle ':fzf-tab:*' fzf-pad 250
      zstyle ':fzf-tab:*' fzf-flags --preview-window=right,70%,cycle" \
        Aloxaf/fzf-tab \
    atload'export LESSOPEN="|${ZSH_HOME}/lessfilter %s"' \
        Freed-Wu/fzf-tab-source

# Second set of plugins
zinit lucid light-mode wait"0b" for \
        OMZP::command-not-found \
        ael-code/zsh-colored-man-pages \
    from"gh" pick"per-directory-history.plugin.zsh" \
    atload'
      export HISTORY_BASE="${ZSH_HOME}/.directory_history"
      export HISTORY_START_WITH_GLOBAL=true' \
        jimhester/per-directory-history \
    atinit"zstyle :history-search-multi-word page-size 10" \
        zdharma-continuum/history-search-multi-word \
    atinit'
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
      ZSH_AUTOSUGGEST_STRATEGY=(dir_history history completion)
      ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)"' \
    atload"
      _zsh_autosuggest_start
      bindkey '^]' autosuggest-execute
      bindkey '^[[1;3C' autosuggest-accept" \
        zsh-users/zsh-autosuggestions \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
    compile'.*fast*~*.zwc' \
    atpull'%atclone' \
    atload"
      export FAST_HIGHLIGHT_STYLES[comment]=fg=yellow,bold
      export FAST_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
      zle_highlight=('paste:none')" \
    nocompletions \
        zdharma-continuum/fast-syntax-highlighting \
    atclone"gdircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload"zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'" \
        trapd00r/LS_COLORS

# Third set of plugins
zinit lucid light-mode wait"0c" for \
    atload"zicdreplay" \
        voronkovich/gitignore.plugin.zsh \
    atload"source <(kubectl completion zsh)" \
        OMZP::kubectl \
    atload"export GIT_AUTO_FETCH_INTERVAL=7200" \
        OMZP::git-auto-fetch \
    atload"
      export SHOW_AWS_PROMPT=false
      complete -C '/opt/homebrew/bin/aws_completer' aws" \
        OMZP::aws \
    atload"export ZSH_ALIAS_FINDER_AUTOMATIC=true" \
        OMZP::alias-finder \
    trigger-load"!x" \
        OMZP::extract

# Install shell programs once compinit has been executed
zinit ice wait"0c" lucid
zinit snippet "${ZSH_HOME}/programs.zsh"

# Set of plugins to load on demand
zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)bd*]} ]]' lucid
zinit light Tarrasch/zsh-bd

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)copy*]} ]]' lucid
zinit light ChrisPenner/copy-pasta

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)gitit*]} ]]' lucid
zinit light peterhurford/git-it-on.zsh

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)docker*]} ]]' lucid as"completion" atload'export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker'
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)go*]} ]]' lucid as"completion"
zinit snippet https://github.com/zsh-users/zsh-completions/blob/master/src/_golang

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)http*]} ]]' lucid as"completion"
zinit snippet https://github.com/zsh-users/zsh-completions/blob/master/src/_httpie

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)rg*]} ]]' lucid as"completion"
zinit snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)helm*]} ]]' lucid as"completion" atload"helm completion zsh >| ${ZSH_HOME}/custom/_helm"
zinit snippet "${ZSH_HOME}/custom/_helm"

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]' lucid
zinit light zdharma-continuum/zui

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]' lucid
zinit light zdharma-continuum/zinit-crasis

# Make sure atuin is installed before loading its zsh plugin
zinit from"gh-r" binary lman for \
    sbin"**/atuin" ellie/atuin

zinit ice wait"5" lucid \
    from"gh" pick"atuin.plugin.zsh" \
    atinit"export ATUIN_NOBIND='true'" \
    atload"bindkey '^[e' _atuin_search_widget"
zinit snippet https://github.com/ellie/atuin/blob/main/atuin.plugin.zsh