# Shorthands
alias -g sudo="sudo "
alias -g N='sudo -E n -e'
alias -g ssctl="sudo systemctl"
alias -g tlmgr="sudo tlmgr"
alias -g cat="bat"
alias -g less="/opt/homebrew/bin/less"
alias -g yat="bat -l yaml"
alias -g airshare="sudo airshare"
alias -g mkdir="mkdir -pv"
alias -g mv="mv -i"
alias -g cp="cp -ir"
alias ls="exa --git --color=always --color-scale --group-directories-first"
alias -g l="exa -aghl --git --color=always --color-scale --group-directories-first"
alias -g tcpdump="sudo tcpdump"
alias -g k="kubectl"
alias -g ks="kubectl --context=\"stage\""
alias -g kt="kubectl --context=\"test\""
alias -g vim="nvim"
alias -g v="nvim"
alias -g kssh="kitty +kitten ssh"
alias -g oldbrew="/usr/local/bin/brew"

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
alias -g prod-sgp="export AWS_PROFILE=prod AWS_REGION=ap-southeast-1;kubectl ctx prod-sgp"
alias -g stage-ore="export AWS_PROFILE=stage AWS_REGION=us-west-2;kubectl ctx stage-ore"
