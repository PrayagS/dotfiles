# All of the above using the for-syntax and also z-a-bin-gem-node annex
# zinit from"gh-r" binary as"null" for \
#      sbin"**/fd"        @sharkdp/fd \
#      sbin"**/bat"       @sharkdp/bat \
#      sbin"**/fzf"       junegunn/fzf \
#      sbin"**/exa"       ogham/exa

zinit from"gh-r" binary lman for \
    sbin"**/fzf" junegunn/fzf \
    sbin"**/exa" ogham/exa \
    sbin"**/fd"  @sharkdp/fd \
    sbin"**/bat" @sharkdp/bat \
    sbin"**/glow" charmbracelet/glow \
    sbin"**/rg" BurntSushi/ripgrep \
    sbin"**/rga" phiresky/ripgrep-all \
    sbin"**/vhs" charmbracelet/vhs \
    sbin"**/carbonyl" fathyb/carbonyl \
    sbin"**/lazygit" atload'alias -g lg=lazygit' jesseduffield/lazygit \
    sbin'**/gh' atclone'./**/gh completion --shell zsh > _gh' atpull'%atclone' cli/cli \
    sbin'pint* -> pint' cloudflare/pint
    # sbin'**/helm' atclone'./**/helm completion zsh > _helm' atpull'%atclone' helm/helm


zinit from"gh" binary as"null" for \
    sbin"bin/*" tj/git-extras \
    sbin"**/git-now" iwata/git-now \
    sbin"**/xdg-ninja.sh" b3nj5m1n/xdg-ninja

# Install Rust and make it available globally
zinit for \
    atload='
      [[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zinit creinstall rust
      export CARGO_HOME=\$PWD RUSTUP_HOME=$PWD/rustup' \
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
    id-as'rust-csvlens' \
    cargo'!csvlens' \
  zdharma-continuum/null