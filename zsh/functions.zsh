# mkcd
function mkcd() {
    dir="$*"
    mkdir -p "$dir" && cd "$dir"
}

# Redraw shell on resize
TRAPWINCH() {
    zle && zle -R
}

# quick add to path
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
