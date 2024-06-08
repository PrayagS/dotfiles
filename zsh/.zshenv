# ZDOTDIR
export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}

# Golang env vars
export GOPATH="$HOME/dev/go"
export GOBIN="$GOPATH/bin"
export GOOS="darwin"
export GOARCH="arm64"
export GO111MODULE="on"

# Defaults
export KUBECONFIG="$HOME/.kubeconfig"
export QT_QPA_PLATFORMTHEME="qt5ct"
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'
export EDITOR="nvim"
# export PAGER="less"
export PAGER="moar"
export MOAR="-statusbar=bold -style=catppuccin-mocha -wrap"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
export TERMINAL="alacritty"
export BROWSER="google-chrome-stable"
export LOLCOMMITS_DEVICE=/dev/video0
export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/dev/dotfiles/macos/Brewfile"

# Being a XDG Ninja
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/rediscli_history"
export SQLITE_HISTORY="$XDG_CACHE_HOME/sqlite_history"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"

# Start skhd/yabai
# if pgrep -x "yabai" >/dev/null
# then
# else
#    yabai
#    echo "yabai started"
# fi
