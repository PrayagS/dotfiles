# All of the above using the for-syntax and also z-a-bin-gem-node annex
# zinit from"gh-r" binary as"null" for \
#      sbin"**/fd"        @sharkdp/fd \
#      sbin"**/bat"       @sharkdp/bat \
#      sbin"**/fzf"       junegunn/fzf \
#      sbin"**/exa"       ogham/exa

zinit from"gh-r" lman for \
    sbin"**/fzf" junegunn/fzf \
    sbin"**/fd" @sharkdp/fd \
    sbin"**/bat" @sharkdp/bat \
    sbin"**/hyperfine" @sharkdp/hyperfine \
    sbin"**/glow" charmbracelet/glow \
    sbin"**/rg" BurntSushi/ripgrep \
    sbin"**/rga" phiresky/ripgrep-all \
    sbin"**/vhs" charmbracelet/vhs \
    sbin"**/carbonyl" fathyb/carbonyl \
    sbin"**/moar* -> moar" walles/moar \
    sbin"**/lazygit" atload'alias -g lg=lazygit' jesseduffield/lazygit \
    sbin'**/gh' atclone'./**/gh completion --shell zsh > _gh' atpull'%atclone' cli/cli \
    sbin'pint* -> pint' cloudflare/pint \
    sbin'**/circumflex* -> circumflex' bensadeh/circumflex \
    sbin"jq* -> jq" jqlang/jq \
    sbin"**/jqp* -> jqp" noahgorstein/jqp \
    sbin"**/nvim" neovim/neovim \
    sbin"**/viddy -> viddy" sachaos/viddy \
    sbin"**/dust -> dust" bootandy/dust \
    sbin"**/duf -> duf" muesli/duf \
    sbin"**/mcfly -> mcfly" cantino/mcfly \
    sbin"**/procs -> procs" dalance/procs \
    sbin"promtool" prometheus/prometheus \
    sbin"**/delta -> delta" dandavison/delta \
    sbin"**/gs -> gs" abhinav/git-spice \
    sbin"**/git-absorb -> git-absorb" tummychow/git-absorb \
    sbin"yq** -> yq" mikefarah/yq \
    sbin"**/usql -> usql" xo/usql \
    sbin"devpod* -> devpod" loft-sh/devpod \
    sbin"**/jj  -> jj" jj-vcs/jj \
    sbin"**/jjui* -> jjui" idursun/jjui \
    sbin"code2prompt* -> code2prompt" mufeedvh/code2prompt \
    sbin"logcli* -> logcli" grafana/loki
# sbin'**/helm' atclone'./**/helm completion zsh > _helm' atpull'%atclone' helm/helm

zinit from"gh" as"null" for \
    sbin"**/git-now" iwata/git-now \
    sbin"**/xdg-ninja.sh" b3nj5m1n/xdg-ninja

# Install Rust and make it available globally
zinit for \
    atload='
      [[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zinit creinstall rust
      export CARGO_HOME=$ZSH_HOME/zinit/cargo RUSTUP_HOME=$ZSH_HOME/zinit/cargo/rustup' \
    as=null \
    id-as=rust \
    lucid \
    light-mode \
    rustup \
    sbin="bin/*" \
    wait=1 \
    zdharma-continuum/null

zinit for \
    light-mode \
    lucid \
    wait='[[ -v CARGO_HOME && -v RUSTUP_HOME ]]' \
    id-as'rust-eza' \
    cargo'!eza' \
    zdharma-continuum/null

zinit for \
    light-mode \
    lucid \
    wait='[[ -v CARGO_HOME && -v RUSTUP_HOME ]]' \
    id-as'rust-yazi-fm' \
    cargo'!yazi-fm -> yazi' \
    zdharma-continuum/null

zinit for \
    light-mode \
    lucid \
    wait='[[ -v CARGO_HOME && -v RUSTUP_HOME ]]' \
    id-as'rust-yazi-cli' \
    cargo'!yazi-cli -> ya' \
    zdharma-continuum/null

zinit for \
    light-mode \
    lucid \
    wait='[[ -v CARGO_HOME && -v RUSTUP_HOME ]]' \
    id-as'rust-csvlens' \
    cargo'!csvlens' \
    zdharma-continuum/null

zinit for \
    light-mode \
    lucid \
    as'null' \
    id-as'magika' \
    pip'magika <- !magika -> magika' \
    zdharma-continuum/null

# zinit for \
#     light-mode \
#     lucid \
#     as'null' \
#     id-as'uv' \
#     pip'uv <- !uv -> uv' \
#     zdharma-continuum/null

zinit from"gh-r" lman for \
    sbin"ani-cli" pystardust/ani-cli
