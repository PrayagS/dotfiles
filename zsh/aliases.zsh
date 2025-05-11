# Shorthands
alias sudo="sudo -B"
alias N='sudo -E n -e'
alias ssctl="sudo systemctl"
alias tlmgr="sudo tlmgr"
alias cat="bat"
alias less="/opt/homebrew/bin/less"
alias rsync="/opt/homebrew/bin/rsync"
alias yat="bat -l yaml"
alias airshare="sudo airshare"
alias mkdir="mkdir -pv"
alias mv="mv -i"
alias cp="cp -ir"
alias l="eza -la --color=always --color-scale=size --color-scale-mode=fixed --icons=always --group-directories-first --smart-group -o --no-permissions --git"
alias ls="eza -a1 --color=always --icons=always --hyperlink --group-directories-first"
alias lsg="eza -la --color=always --color-scale=size --color-scale-mode=fixed --icons=always --group-directories-first --smart-group -o --no-permissions --git --git-ignore"
alias lt="eza -la --color=always --color-scale=size --color-scale-mode=fixed --icons=always --group-directories-first --smart-group -o --no-permissions --git -T"
alias tcpdump="sudo tcpdump"
alias -g k="kubectl"
alias vim="nvim"
alias v="nvim"
alias kssh="kitty +kitten ssh"
alias oldbrew="/usr/local/bin/brew"
alias lg="lazygit"
alias jjs="jj && jj st"
alias wget="wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\""
alias fd="fd --hidden --follow --regex --full-path"
alias cdg="cd-gitroot"

# Launch
alias -g filebot="java -jar /home/prayag_s/Downloads/misc-stuff/filebot/FileBot.jar"
alias -g sxiv="sxiv -a"
alias -g emu8086="WINEPREFIX=~/Games/osu\! wine Games/osu\!/drive_c/emu8086/emu8086.exe & disown && exit"

# Pacman
alias -g pacrmcache="sudo pacman -Scc"
alias -g yeet="yay -Rsn"
alias -g fixmirrors="sudo pacman-mirrors --fasttrack && sudo pacman -Syyu"

# Plex
alias -g plexstart="sudo systemctl start plexmediaserver.service && /opt/google/chrome/google-chrome --profile-directory="Default" -a http://localhost:32400/web/index.html"
alias -g plexstop="sudo systemctl stop plexmediaserver.service"

# VPN
alias -g connectvpn="sudo systemctl start windscribe"
alias -g disconnectvpn="windscribe disconnect && sudo systemctl stop windscribe"

# PostgreSQL and PgAdmin
alias -g startdb="sudo systemctl start postgresql.service && sudo python3 /usr/lib/pgadmin4/web/pgAdmin4.py"
alias -g stopdb="sudo systemctl stop postgresql.service"

# Misc
alias -g findkeyname="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'"
alias -g rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

# Work
alias prod-sgp="export AWS_PROFILE=prod AWS_REGION=ap-southeast-1"
alias stage-ore="export AWS_PROFILE=stage AWS_REGION=us-west-2"
alias blinkit-analytics="export AWS_PROFILE=blinkit_analytics AWS_REGION=ap-southeast-1"
ssm() {
    instance_id=$(kubectl describe node "$1" | grep "alpha.eksctl.io/instance-id" | awk -F '=' '{ print $2 }')
    aws ssm start-session --target "$instance_id"
}
