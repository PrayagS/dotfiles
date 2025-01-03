# bindkey --help
# -e -> emacs mode
# -v -> vi insert mode
# -a -> vi cmd mode
# -M <keymap>
# -l -> list all keymaps
# More here: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins

# List of available widgets: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# start in insert mode
bindkey -v

# jj in insert mode is escape
bindkey -M viins 'jj' vi-cmd-mode
export KEYTIMEOUT=20

# some standard vi key bindings
bindkey -a 'u' undo
bindkey -a '^R' redo
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history
bindkey -a 'j' vi-down-line-or-history
bindkey -a 'k' vi-up-line-or-history
bindkey -a '$' vi-end-of-line
# bindkey -a '^' vi-beginning-of-line


# bindkey '^?' backward-delete-char

bindkey -M viins '^r' history-search-multi-word
bindkey -M vicmd '^r' history-search-multi-word

bindkey '^]' vi-forward-word
bindkey '^[' vi-backward-word

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey -M viins '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

# Use vim keys in tab complete menu:
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[1 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[1 q"
}
zle -N zle-line-init
echo -ne '\e[1 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[1 q' ;} # Use beam shape cursor for each new prompt.

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

# alt+shift+s to toggle sudo
function vbe-sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N vbe-sudo-command-line
bindkey "\eS" vbe-sudo-command-line
