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
ZINIT[NO_ALIASES]=1

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
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-link-man \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/zinit-annex-patch-dl

### End of Zinit's installer chunk

zinit snippet "${ZSH_HOME}/options.zsh"
zinit snippet "${ZSH_HOME}/bindkeys.zsh"
zinit snippet "${ZSH_HOME}/history.zsh"
zinit snippet "${ZSH_HOME}/aliases.zsh"
zinit snippet "${ZSH_HOME}/functions.zsh"
zinit snippet "${ZSH_HOME}/completion.zsh"

# disable the arrow keys
bindkey -s "^[[A" ""
bindkey -s "^[[B" ""
bindkey -s "^[[C" ""
bindkey -s "^[[D" ""

# Prompt
PS1="READY >"
zinit ice wait"!" lucid atload"source ${ZSH_HOME}/themes/.p10k.zsh; _p9k_precmd" nocd
zinit light romkatv/powerlevel10k

# Set fzf options
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=bg:#1b1b1b
    --color=preview-bg:#1b1b1b
    --color=hl+:#fb4934
    --color=gutter:#1b1b1b
    --color=pointer:#f9f5d7,marker:#f9f5d7
    --color=info:#ebdbb2,spinner:#f9f5d7
    --color=query:#ebdbb2,prompt:#ebdbb2
    --color=border:#ebdbb2
    --border="rounded" --prompt="> "
    --marker="" --pointer="->" --layout="reverse"
'

# Make sure zoxide is installed before loading its zsh plugin
zinit from"gh-r" lman for \
    sbin"**/zoxide" ajeetdsouza/zoxide

# First set of plugins
zinit lucid light-mode wait"0a" for \
        OMZL::git.zsh \
        OMZL::clipboard.zsh \
        https://github.com/wez/wezterm/blob/main/assets/shell-integration/wezterm.sh \
        https://github.com/ajeetdsouza/zoxide/blob/main/zoxide.plugin.zsh \
    atload'export GLOBALIAS_FILTER_VALUES=("l" "ls" "less" "z")' \
        OMZP::globalias \
    atload'alias -g cdg="cd-gitroot"' \
        mollifier/cd-gitroot \
    compile'lib/*f*~*.zwc' \
    blockf \
    atload"
      zstyle ':fzf-tab:*' fzf-pad 250
      zstyle ':fzf-tab:*' continuous-trigger ']'
      zstyle ':fzf-tab:*' use-fzf-default-opts yes
      zstyle ':fzf-tab:*' switch-group 'ctrl-h' 'ctrl-l'" \
        Aloxaf/fzf-tab \
    atload"
      export LESSOPEN='|${ZSH_HOME}/lessfilter %s'
      zstyle ':fzf-tab:sources' config-directory ${ZSH_HOME}/fzf-tab-custom-sources" \
        Freed-Wu/fzf-tab-source
        # OMZP::git \

# Second set of plugins
zinit lucid light-mode wait"0b" for \
        OMZP::command-not-found \
        ael-code/zsh-colored-man-pages \
    atinit"
        zstyle :history-search-multi-word page-size 20
        zstyle :history-search-multi-word highlight-color 'fg=#b8bb26,bold'
        zstyle :plugin:history-search-multi-word active 'bg=#504945'
        zstyle :plugin:history-search-multi-word clear-on-cancel 'yes'
      " \
    patch"$ZSH_HOME/plugin-patches/history-search-multi-word/0001-key-bindings.patch" \
        zdharma-continuum/history-search-multi-word \
    atinit'
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)"' \
    atload"
      _zsh_autosuggest_start
      bindkey -M viins '^]' autosuggest-execute
      bindkey -M vicmd '^]' autosuggest-execute
      # bindkey -M viins '^[[1;3C' autosuggest-accept
      # bindkey -M vicmd '^[[1;3C' autosuggest-accept" \
        zsh-users/zsh-autosuggestions \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay; autoload bashcompinit; bashcompinit" \
    atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
    compile'.*fast*~*.zwc' \
    atpull'%atclone' \
    atload"
      export FAST_HIGHLIGHT_STYLES[comment]=fg=yellow,bold
      export FAST_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
      zle_highlight=('paste:none')" \
    nocompletions \
        zdharma-continuum/fast-syntax-highlighting
    # from"gh" pick"per-directory-history.plugin.zsh" \
    # atload'
    #   export HISTORY_BASE="${ZSH_HOME}/.directory_history"
    #   export HISTORY_START_WITH_GLOBAL=true' \
    #     jimhester/per-directory-history \
    # Disabling LS_COLORS since it's causing problems while sourcing zshrc
    # atclone"gdircolors -b LS_COLORS >| clrs.zsh" \
    # atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    # atload"zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'" \
    #     trapd00r/LS_COLORS

# Third set of plugins
# zinit lucid light-mode wait"0c" for \
    # atload"source <(kubectl completion zsh)" \
    #     OMZP::kubectl \
    # atload"export GIT_AUTO_FETCH_INTERVAL=7200" \
    #     OMZP::git-auto-fetch \
    # atload"export ZSH_ALIAS_FINDER_AUTOMATIC=true" \
    #     OMZP::alias-finder \

zinit lucid light-mode wait"2" for \
    hlissner/zsh-autopair \
    trigger-load"!x" \
        OMZP::extract \
    atload"zicdreplay" \
        voronkovich/gitignore.plugin.zsh \
    atload"
      export SHOW_AWS_PROMPT=false
      complete -C '/opt/homebrew/bin/aws_completer' aws" \
        OMZP::aws \
    fdw/yazi-zoxide-zsh \
    ahmubashshir/zinsults \
    akash329d/zsh-alias-finder
    # atload"
    #   export KUBECTL_PATH=/opt/homebrew/bin/kubectl
    #   export KUBECTL_SAFE_TIME=300" \
    #     benjefferies/safe-kubectl \

# Make sure atuin is installed before loading its zsh plugin
zinit ice sbin"**/atuin" from"gh-r" bpick"*.gz" lman
zinit light atuinsh/atuin

zinit ice wait"5" lucid \
    from"gh" pick"atuin.plugin.zsh" \
    atinit"export ATUIN_NOBIND='true'" \
    atload"bindkey '^[e' _atuin_search_widget"
zinit snippet https://github.com/atuinsh/atuin/blob/main/atuin.plugin.zsh

# Install shell tools once compinit has been executed
zinit ice wait"10" lucid
zinit snippet "${ZSH_HOME}/tools.zsh"

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

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)rg*]} ]]' lucid as"completion" atload"rg --generate complete-zsh >| ${ZSH_HOME}/custom/_rg"
zinit snippet "${ZSH_HOME}/custom/_rg"

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)helm*]} ]]' lucid as"completion" atload"helm completion zsh >| ${ZSH_HOME}/custom/_helm"
zinit snippet "${ZSH_HOME}/custom/_helm"

# zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)jj*]} ]]' lucid as"completion" atload"COMPLETE=zsh jj >| ${ZSH_HOME}/custom/_jj"
# zinit snippet "${ZSH_HOME}/custom/_jj"
autoload compinit; compinit;
source <(COMPLETE=zsh jj)

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]' lucid
zinit light zdharma-continuum/zui

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]' lucid
zinit light zdharma-continuum/zinit-crasis

# pyenv virtualenv
# eval "$(pyenv virtualenv-init -)"
