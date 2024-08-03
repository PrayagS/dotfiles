# ZDOTDIR
export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}

# Path
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH
export PATH=/usr/local/texlive/2021/texmf-dist/scripts:$PATH
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.npm-global/bin:$PATH
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.krew/bin:$PATH"
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.config/zsh/zinit/polaris/bin:$PATH"
# export GOPATH="$HOME/dev/go"
# export GOBIN="$GOPATH/bin"
# export PATH="$GOBIN:$PATH"

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
export XDG_STATE_HOME="$HOME/.local/state"
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
export KREW_ROOT="$XDG_DATA_HOME/krew"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"

# Start skhd/yabai
# if pgrep -x "yabai" >/dev/null
# then
# else
#    yabai
#    echo "yabai started"
# fi
