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
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.krew/bin"
export PATH="$PATH:$HOME/Library/Python/3.8/bin"
export PATH="$PATH:/opt/homebrew/bin"

# Golang env vars
export GOPATH="$HOME/dev/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"
export GOOS="darwin"
export GOARCH="amd64"
export GO111MODULE="on"

# Defaults
export QT_QPA_PLATFORMTHEME="qt5ct"
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'
export EDITOR="nvim"
export PAGER="less"
export TERMINAL="alacritty"
export BROWSER="google-chrome-stable"
export LOLCOMMITS_DEVICE=/dev/video0
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--cycle"
export K9SCONFIG="$HOME/.config/k9s"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"

# Start skhd
#if pgrep -x "skhd" >/dev/null
#then
#else
#    skhd -c ~/.config/skhd/skhdrc -P -V
#    echo "skhd started"
#fi
