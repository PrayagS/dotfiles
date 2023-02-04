# mkcd
function mkcd() {
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

# Redraw shell on resize
TRAPWINCH() {
    zle &&  zle -R
}

# quick add to path
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# lazygit wrapper
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# nnn wrapper
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

    STUDY_PATH="/mnt/DATA/Study/Monsoon_2021"

    NNN_BMS="1:$STUDY_PATH/CSE524;2:$STUDY_PATH/CSE525;3:$STUDY_PATH/CSE527;4:$STUDY_PATH/CSE540;5:$STUDY_PATH/JAP111;"
    export NNN_BMS

    NNN_PLUG="z:autojump;d:dragdrop;c:fzcd;f:fzopen;p:preview-tabbed;"
    export NNN_PLUG

    export NNN_OPTS="aAdexDHU"
    export NNN_TRASH="1"
    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

_zsh_autosuggest_strategy_dir_history(){ # Avoid Zinit picking this up as a completion
    emulate -L zsh
    if $_per_directory_history_is_global && [[ -r "$_per_directory_history_path" ]]; then
        setopt EXTENDED_GLOB
        local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
        local pattern="$prefix*"
        if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]; then
        pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"
        fi
        [[ "${dir_history[(r)$pattern]}" != "$prefix" ]] && \
        typeset -g suggestion="${dir_history[(r)$pattern]}"
    fi
}
