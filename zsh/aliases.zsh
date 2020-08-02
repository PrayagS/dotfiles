# Shorthand aliases
alias sudo="sudo "
alias ssctl="sudo systemctl"
alias tlmgr="sudo tlmgr"
alias cat="bat"
alias airshare="sudo airshare"
alias mkdir="mkdir -pv"
alias ls="exa"
alias la="exa -glah --git --color-scale"
alias ll="exa -glh --git --color-scale"
alias l="exa -lh --git --color-scale"

# Launch aliases
alias nvidia-settings="optirun -b none nvidia-settings -c :8"
alias filebot="java -jar /home/prayag_s/Downloads/misc-stuff/filebot/FileBot.jar"
alias sxiv="sxiv -a"

# Pacman aliases
alias pacrmcache="sudo pacman -Scc"
alias yeet="yay -Rsn"
alias fixmirrors="sudo pacman-mirrors --fasttrack && sudo pacman -Syyu"

# Plex
alias plexstart="sudo systemctl start plexmediaserver.service && /opt/google/chrome/google-chrome -a http://localhost:32400/web/index.html"
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
