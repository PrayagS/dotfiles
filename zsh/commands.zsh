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
    sbin"**/lazygit" atload'alias -g lg=lazygit' jesseduffield/lazygit \
    sbin'**/gh' atclone'./**/gh completion --shell zsh > _gh' atpull'%atclone' cli/cli
    # sbin'**/helm' atclone'./**/helm completion zsh > _helm' atpull'%atclone' helm/helm


zinit from"gh" binary as"null" for \
    sbin"bin/*" tj/git-extras \
    sbin"**/git-now" iwata/git-now
