# Shorthand aliases
alias sudo="sudo "
alias N='sudo -E n -e'
alias ssctl="sudo systemctl"
alias tlmgr="sudo tlmgr"
alias cat="bat"
alias airshare="sudo airshare"
alias mkdir="mkdir -pv"
alias mv="mv -i"
alias cp="cp -ir"
alias ls="exa"
alias la="exa -glah --git --color-scale"
alias ll="exa -glh --git --color-scale"
alias l="exa -lh --git --color-scale"
alias tcpdump="sudo tcpdump"
alias k="kubectl"

# Launch aliases
alias filebot="java -jar /home/prayag_s/Downloads/misc-stuff/filebot/FileBot.jar"
alias sxiv="sxiv -a"
alias emu8086="WINEPREFIX=~/Games/osu\! wine Games/osu\!/drive_c/emu8086/emu8086.exe & disown && exit"

# Pacman aliases
alias pacrmcache="sudo pacman -Scc"
alias yeet="yay -Rsn"
alias fixmirrors="sudo pacman-mirrors --fasttrack && sudo pacman -Syyu"

# Plex
alias plexstart="sudo systemctl start plexmediaserver.service && /opt/google/chrome/google-chrome --profile-directory="Default" -a http://localhost:32400/web/index.html"
alias plexstop="sudo systemctl stop plexmediaserver.service"

# VPN
alias connectvpn="sudo systemctl start windscribe"
alias disconnectvpn="windscribe disconnect && sudo systemctl stop windscribe"

# PostgreSQL and PgAdmin
alias startdb="sudo systemctl start postgresql.service && sudo python3 /usr/lib/pgadmin4/web/pgAdmin4.py"
alias stopdb="sudo systemctl stop postgresql.service"

# Misc
alias findkeyname="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'"
alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
